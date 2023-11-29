#Viewing the Data
SELECT * FROM users;
SELECT * FROM photos;
SELECT * FROM tags;
SELECT * FROM likes;
SELECT * FROM photo_tags;
SELECT * FROM follows;

#Most loyal Users
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

#Inactive User Engagement
SELECT COUNT(DISTINCT(username)) as UsersWithoutPhotos
FROM users u
LEFT JOIN photos s ON u.id = s.user_id
WHERE s.id is NULL;

#Contest Winner Declaration
SELECT u.username username, p.user_id, l.photo_id photoID, COUNT(l.photo_id) as Likes
FROM photos p
INNER JOIN likes l ON p.id = l.photo_id
INNER JOIN users u ON u.id = p.user_id
GROUP BY p.user_id, l.photo_id
ORDER BY Likes DESC
LIMIT 1;

#Hashtag Research
SELECT pt.tag_id, tag_name, COUNT(tag_name) total
FROM photo_tags pt
LEFT JOIN tags t ON pt.tag_id = t.id
GROUP BY pt.tag_id
ORDER BY 3 DESC
LIMIT 5;

#Ad Campaign Launch
SELECT DAY(created_at) Day, COUNT(username) RegisteredUsers 
FROM users
GROUP BY 1
ORDER BY 2 DESC;

#User Engagement
SELECT COUNT(p.id)/COUNT(DISTINCT(username)) avg
FROM photos p INNER JOIN users u ON p.user_id = u.id;

SELECT (SELECT count(*) from photos) / (SELECT count(*) from users) as TotalAvg;

#Bots & Fake Accounts
SELECT user_id,username, COUNT(photo_id) TotalLikedPosts
FROM likes l JOIN users u  ON l.user_id = u.id
GROUP BY 1
HAVING COUNT(photo_id) = 257
ORDER BY 2 DESC;