== README
#DCE CONNECT
** a tumblr based microblogging site **
> Minor & WebD project

## Overview

### Tables to be created 
  - user (details... ,uid)
  - category (name, desc)
  - weights (category_id,user_id, no_of_likes_by_user, selected, no_of_posts_in_category, weight(x), total_weight(n)). 
    (Has-many through relation between user and category table)  
  - posts(pid, category, content, title, *media(url)*, likes)
    
### Flow of events :
  1. Extraction of posts
  2. Creating pseudo Table
  3. Assigning weights
  4. Sort
  
#### 1. Extraction of posts
              
   1. On the basis of timestamp, extract posts which are one month/week (to be decided) old and assign weights to                 them. 
   2. Display rest in a reverse chronological order
              
  
#### 2. Creating a pseudo Table
    
   1. From the extracted posts, create a pseudo table
              
  
#### 3. Algorithm for assigning weight to extracted posts
  
   1. On creation of a user account, 
      x=no_of_categories_selected,
      n=total number of categories
      for all categories with selected == true
      category-table.weight = (100/x)
      

   2. After some user interaction with the system
       
     1. change_Weight_Each_Day(category-table.no_of_likes , category-table.no_of_posts)
          
            {
             for each category where selected == true     
              {
                category-table.weight-new = 0.9*category-table.no_of_posts + 0.1*category-table.no_of_likes
                category-table.weight = 0.8*category-table.weight + 0.2*category-table.weight-new
              }
            }


     2. change_total_weight_each_day(category-table.no_of_likes , category-table.no_of_posts)
            
            {
               for each category :
                  {
                    category-table.weight-new = 0.9*category-table.no_of_posts + 0.1*category-table.no_of_likes
                    category-table.weight = 0.8*category-table.weight + 0.2*category-table.weight-new
                  }
             } 

     3. Add/delete category 
           
             {
                check_Category_every_month

                Add_category()

                        {   count=0;
                            for all categories where selected == false
                            {
                                if(total_weight[cat] > 100/n
                                { 
                                  store all categories with greater weight in new_cat
                                  count++; 
                                 }
                            }

                            for all categories where selected == true
                            {
                                weight = weight * x/(x+count)
                            }

                            for all new cat 
                            {
                                selected = true
                                weight = 100/(x+count)
                            }
                         }

               Delete_category


                         {
                              if(no_of_selected>min)
                              {
                                  for all categories where selected == true
                                  {
                                      if(total_weight[cat] < 100/n)
                                      {
                                          count++;
                                          category.selected = false
                                      }
                                  }

                                for all categories where selected = true
                                  weight *= (x+count)/x
                            }
                        }



#### 4. Sort the extracted posts of the pseudo table (pid, final_weight)
         
         {   
           for each pid : 
            {   
                st = pid.category  						//from posts table	
                category_weight = category-table.weight[st]
                final_weight = pid.likes * category_weight                
            }
           select * from pseudo table order by final_weight.
          } 
            
## Detailed Description of the Project

### Softwares used for development
- Operating System : Ubuntu 
- Language : Ruby
- Framework : Rails
- Databases : PostgreSQL
- Hosting : Heroku

### Detailed steps for Development
1. Setting up of rails on Ubuntu Operating System. 

2. Generation of a new project named **dceconnect* with *PostgreSQL** : The default is SQLite but it cannot be hosted on heroku. Hence, the reason of the choice. Created with the command `rails g new dceconnect --database postgresql`

3. Creation of models
  1. Creation of the first model, **User** with fields *Name, Username, Password (encrypted), Email, Phone, Academic-Year* : This model stores the details of all users in the system. The model is created by the command `rails g model user`. It is then migrated to the database. 

  2. Creation of the second model **Category** with fields *Name, Description* : This model stores all the categories in the system along with their descriptions. The model is created by the command `rails g model categories`. It is then migrated to the database.

  3. Linking the Users and Categories :  The **User** model is linked with the **Category** table via a **Has-many-through** association through the **Weight** model, i.e., 
- User has many Weights; User has many categories through weights. 
- Categories have many weights; Categories have many users through Weights. 
- Weight belongs to user; Weight belongs to Categories.
  This creates a Many-to-Many relationship between Users and Categories through Weights. 
  The **Weight** model has attributes *Category_id, User_id, Selected, no_of_likes_by_user, no_of_posts_in_category, weight,   total_weight* 
  
4. Creation of Controllers
  1. The *user controller* is generated using the command `rails g controller user`. The controller contains various actions to be performed by the controller. The flow of control between the actions of the controller is managed by the routes.rb file which contains the routing information of each action. Views of those actions which are requested from the server (method=get) are made. The views and actions in the order of their creation are :
    
    * Index - The control is passed to this action as soon as the site load on a client machine. This action has a view which displays the login and signup buttons redirecting to their respective flows on being clicked.
    
    * Signup - This action has a view requesting the details of the users to create an account in the system. The details are passed to the Add_session action via a form and the details are sent to the server using the post method. 
    
    * Add_Session - This action receives the details of the new user, adds it to the database and begins a user session. Hence passing control to the action Welcome, which displays the user name and a logout button.
    
    * Logout - On clicking the Logout button in Welcome view, the control is passed to the logout action which ends the user session. 
    
    * Login - This action has a view requesting the user to enter the username and password. The details are passed to the Add_session_login action via a form and the details are sent to the server using the post method. 
    
    * Add_session_login -  This action receives the details of the new user, and checks in the database :
      - If the user exists, and the password matches, the control passes to action welcome 
      - If the user exists, and the password does not match, the user is prompted to enter the password again. 
      - If the user does not exist, the user is redirected to action signup.
    

  
    
