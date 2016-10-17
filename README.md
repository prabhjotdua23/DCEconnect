== README

on signup 
  create table user (details... ,uid, categories)
  
on each post by any user
  create table posts(pid, category, content, title, *media(url)*, likes
  
create a category table for each category (for easy routing of the "category-sise-posts section

also create a user-category table with primary key category
  create category-table(category, no_of_likes_by_user, selected, no_of_posts_in_category, weight(x), total_weight(n))
  
Flow of events :
1. Extraction of posts
2. Creating pseudo Table
3. Assigning weights
4. Sort
  
  1. Extraction of posts
  on the basis of timestamp, extract posts which are one month/week (to be decided) old and assign weights to them. 
  Display rest in a reverse chronological order
  
  2. Creating a pseudo Table
  From the extracted posts, create a pseudo table
  
  3. Algorithm for assigning weight to extracted posts
      3.1 On creation of a user account, 
      x=no_of_categories_selected,
      n=total number of categories
      
      for all categories with selected == true
      category-table.weight = (100/x)
      
      3.2 after some user interaction with the system
  
         3.2.1 change_Weight_Each_Day(category-table.no_of_likes , category-table.no_of_posts)
         {
          for each category where selected == true     
              {
              category-table.weight-new = 0.9*category-table.no_of_posts + 0.1*category-table.no_of_likes                                   category-table.weight = 0.8*category-table.weight + 0.2*category-table.weight-new
              }
         }
         
         3.2.2 change_total_weight_each_day(category-table.no_of_likes , category-table.no_of_posts)
         {
          for each category :
              {
              category-table.weight-new = 0.9*category-table.no_of_posts + 0.1*category-table.no_of_likes                                   category-table.weight = 0.8*category-table.weight + 0.2*category-table.weight-new
              }
         } 
          
          3.2.3 Add/delete category 
         {
            check_Category_every_month
            
            Add_category()
            {   count=0;
                for all categories where selected == false
                {
                    if(total_weight[cat] > 100/n
                    new_cat[i]=cat
                    count++;
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
                      
                
        
4. Sort the extracted posts of the pseudo table (pid, final_weight)
    {   for each pid : 
           
            {   st = pid.category  						//from posts table	
                category_weight = category-table.weight[st]
                final_weight = pid.likes * category_weight                
            }
         select * from pseudo table order by final_weight.
     } 
