# Total number of apps present in the Google playstore dataset
-- 8199
SELECT COUNT(DISTINCT App)
FROM playstore_apps;

# Number of Categories present in the dataset
-- 33
SELECT COUNT( DISTINCT Category)
FROM playstore_apps;

# All categories with the number of apps in them
SELECT Category, COUNT(*) as Number_of_apps
FROM playstore_apps
GROUP BY Category;

# Average rating and average size of all the apps
SELECT AVG(Rating) as Average_rating, AVG(Size) as Average_Size_inKB
FROM playstore_apps;

# Overview of all categories wrt Number of installs, least rated app, highest rated app, number of free apps and number of paid apps in that category in that category.
SELECT Category, Min(Rating) as Least_rating, Max(Rating) as Highest_rating, SUM(Installs) as Total_installs,
COUNT(CASE WHEN Type = 'Free' THEN 1 END) as Num_of_Free_Apps, 
COUNT(CASE WHEN Type = 'Paid' THEN 1 END) AS Num_of_Paid_Apps
FROM playstore_apps
GROUP BY Category
ORDER BY Total_installs DESC;

# Q.1 Which are the top 10 highest rated apps in the given available dataset?
SELECT App, Rating
FROM playstore_apps
ORDER BY Rating DESC
LIMIT 10;

# Q.2 What are the number of installs and reviews for the above apps? Return the apps with the highest reviews to the top
SELECT App, Rating, Reviews, Installs
FROM playstore_apps
ORDER BY Rating DESC, Reviews DESC
LIMIT 10;

# Q.3 Which app has the highest number of reviews? Also, mention the number of reviews and category of the app
SELECT App, Reviews, Category
FROM playstore_apps
ORDER BY Reviews DESC
LIMIT 1;

# Q.4 What is the total amount of revenue generated by the google play store by hosting apps? (Whenever a user buys apps  from the google play store, the amount is considered in the revenue)
SELECT SUM(Installs*Price) as Total_Revenue
FROM playstore_apps
WHERE Type= 'Paid';

# Q.5 Which Category of google play store apps has the highest number of installs? Also, find out the total number of installs for that particular category.
SELECT Category, SUM(Installs) as No_of_Installs
FROM playstore_apps
Group by Category
ORDER BY No_of_Installs DESC;

# Q.6 Which Genre has the most number of published apps?
SELECT Genres, COUNT(App) as App_count
FROM playstore_apps
GROUP BY Genres
ORDER BY App_count DESC;

# Q.7 Find the count of apps in each content rating based on App type.
SELECT Type,
       SUM(case when (content_rating = 'Unrated') then 1 else 0 end) count_unrated,
       SUM(case when (content_rating = 'Everyone 10+') then 1 else 0 end) count_10plus,
       SUM(case when (content_rating = 'Teen') then 1 else 0 end) count_teen,
       SUM(case when (content_rating = 'Everyone') then 1 else 0 end) count_everyone,
       SUM(case when (content_rating = 'Adults only 18+') then 1 else 0 end) count_18plus,
       SUM(case when (content_rating = 'Mature 17+') then 1 else 0 end) count_17plus
FROM playstore_apps
GROUP BY Type;

# Q.8  Create a new column to bucket rating to high(4-5), medium(2-4), low(0-2). Return the app names
SELECT  
App, rating,
CASE 
    WHEN rating BETWEEN 4 AND 5 THEN 'high'
    WHEN rating BETWEEN 2 AND 4 THEN 'medium'
    ELSE 'low' 
END Rating_category
FROM playstore_apps;

# Q.9 Return categories with their sentiment counts for each type of sentiment
SELECT playstore_apps.Category,
SUM(CASE WHEN (playstore_reviews.sentiment = 'positive') THEN 1 ELSE 0 END) AS positive_count,
SUM(CASE WHEN (playstore_reviews.sentiment = 'negative') THEN 1 ELSE 0 END) AS negative_count,
SUM(CASE WHEN (playstore_reviews.sentiment = 'neutral') THEN 1 ELSE 0 END) AS neutral_count
FROM playstore_apps 
JOIN playstore_reviews on playstore_apps.app = playstore_reviews.app
GROUP BY playstore_apps.Category;

Q.10 Provide the list of all games ordered in such a way that the game that has the highest number of installs is displayed on the top 
SELECT DISTINCT App, Installs, Category
FROM playstore_apps
WHERE Category= 'Game'
ORDER BY Installs DESC;

# Q.11 List all non-entertainment and non-education apps that are rated by everyone or teen
SELECT * 
FROM playstore_apps 
WHERE Category NOT IN ('Entertainment', 'Education')
AND Content_Rating IN ('Everyone', 'Teen');

# Q.12 List all the apps whose app names contain the letter “i” or start with the letter “D”
SELECT * 
FROM playstore_apps 
WHERE App LIKE '%i%' OR App LIKE 'D%';

# Q.13 Return the app names, categories, sizes, release dates (rename it to “Last Updated”) of apps whose app names have more than 1 word, and whose categories are music and social, and whose sizes are bigger than 10. Order the output result by maximum installs in descending order, then release dates in ascending order.
SELECT App, Category, Size, Last_Updated as 'Last Updated'
FROM playstore_apps 
WHERE app LIKE '% %'
AND category IN ('Music', 'Social')
AND size > 10;

# Q.14 Find the number of apps in each category that have a rating greater than the average rating
SELECT Category, COUNT(App) as App_count
FROM playstore_apps
WHERE Rating > 4.2
GROUP BY Category
ORDER BY App_count DESC;

# Q.15 List the largest app size within each app category.
SELECT Category, AVG(Size) as Avg_App_size
FROM playstore_apps
GROUP BY Category
ORDER BY Avg_App_size DESC;



