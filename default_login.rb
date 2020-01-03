



require 'pg'





begin

    con = PG.connect :dbname => 'hello_world_development', :user => 'postgres', 
        :password => 'admin'

    user = con.user
    db_name = con.db
    pswd = con.pass
    
    puts "User: #{user}"
    puts "Database name: #{db_name}"
    puts "Password: #{pswd}" 

    con.exec "INSERT INTO users (created_at, updated_at, email, password) VALUES (27.12.2019, 27.12.2019, test123@test.com, crypt('admin', gen_salt('bf'))"
    
    
rescue PG::Error => e

    puts e.message 
    
ensure

    con.close if con
    
end