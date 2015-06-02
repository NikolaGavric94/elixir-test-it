defmodule Infinityloop.PageController do
  use Infinityloop.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def get_by_analyze_id(id) do
    query = from w in Infinityloop.Item,
          where: w.id_analyze == ^id,
         select: w
    Repo.all(query)
  end
    


  def info(conn, %{"user"=>user, "repo"=>repo, "email"=>email}) do
    id = user <> repo

    all = get_by_analyze_id(id)
    if all != :nil do
	    Enum.each(all, fn x ->     	
    		Repo.delete(x)
	    end)
    end

  	task = Task.async(fn -> 
  		repository = HTTPotion.get "https://api.github.com/repos/"<>user<>"/"<>repo<>"/git/trees/master?recursive=1", [body: "", headers: ["User-Agent": "My App"]]	
	  	
	  	{:ok, globalResponseJSON} = JSON.decode(repository.body)
	  	Enum.each(globalResponseJSON["tree"], fn e ->
			if String.contains?(e["path"], ".exs") or String.contains?(e["path"], ".ex") do  

				response = HTTPotion.get e["url"], [body: "", headers: ["User-Agent": "My App"]]	

		  		{:ok, responseJSON} = JSON.decode(response.body)
				vr = responseJSON["content"]
				var = String.replace(vr, "\n", "")
				
		  		decodedValue = Base.decode64(var)
		  		
				{:ok, decodedValue1} = decodedValue
				{:ok, sv} = JSON.encode(ElixirAnalysis.call_all_functions(decodedValue1))
				vals = %Infinityloop.Item{id_analyze: id, content: sv}
				Repo.insert(vals)


				"""
				from = "infinite.hackathon@gmail.com"
				to = email
				subject = "Static Code Analysis"
				body = decodedValue1
				server = "smtp.gmail.com"
				login = "infinite.hackathon@gmail.com"
				password = "infinityloop"
				ElixirSmtp.send!(from, to, subject, body, server, login, password)
				"""
			end
		end)
  	end)
	
	render conn, "info.html", %{:id => id}
  end 

  def analyze(conn, %{"id"=>id}) do
  	res = get_by_analyze_id(id)
  	p = Enum.map(res, fn x -> 
  		{:ok, toS} = JSON.decode(x.content)
  		toS
  	end)
  	p1 = Enum.map(p, fn x -> 
  		Enum.filter(x, fn y -> 
  			if (y != nil and y != %{}) do 
  				true
  			else
	  			false
	  		end
  		end)
  	end)
  	
  		[pr1] = p1 
  	
  	pr2 = Enum.filter(pr1, fn x -> 
  		#IO.puts(x)
  		if (x["priority"]==1) do
  			true
  		else
  			false
  		end
  	end) 
  	f1 = length(pr2)
  	f2 = length(pr1)-length(pr2)
  	f3 = 0
    render conn, "analyze.html", %{:response=>p1, :first=>f1, :second=>f2, :third=>f3}
  end

end