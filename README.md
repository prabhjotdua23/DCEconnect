== README
#DCE CONNECT
** a tumblr based microblogging site **
> Minor & WebD project

### Signup 
  create table user (details... ,uid, categories)`
  
### Each post by any user

  - create table posts(pid, category, content, title, *media(url)*, likes
  - create a category table for each category (for easy routing of the "category-wise-posts section"
  - also create a category table with primary key category
  - create weights table(category_id,user_is, no_of_likes_by_user, selected, no_of_posts_in_category, weight(x), total_weight(n)). (Has-many through relation between user and category table)
    
## Flow of events :
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
                category-table.weight-new = 0.9*category-table.no_of_posts + 0.1*category-table.no_of_likes                                 category-table.weight = 0.8*category-table.weight + 0.2*category-table.weight-new
              }
            }


     2. change_total_weight_each_day(category-table.no_of_likes , category-table.no_of_posts)

          
             {
               for each category :
                  {
                    category-table.weight-new = 0.9*category-table.no_of_posts + 0.1*category-table.no_of_likes                                 category-table.weight = 0.8*category-table.weight + 0.2*category-table.weight-new
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
            
