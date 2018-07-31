1. 
Select count(DISTINCT utm_source) 
from page_visits;
SELECT count(DISTINCT utm_campaign)
from page_visits;
SELECT DISTINCT utm_source, utm_campaign
from page_visits
order by 1;

2.
SELECT distinct page_name
from page_visits;

3.
WITH first_touch AS (
	SELECT user_id, MIN(timestamp) as first_touch_at
	FROM page_visits
	GROUP BY user_id),
ft_attr AS (
  SELECT ft.user_id,
         ft.first_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM first_touch ft
  JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source as 'source',
       ft_attr.utm_campaign as 'campaign',
       COUNT(*)
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

4.
WITH last_touch AS (
	SELECT user_id, MAX(timestamp) as last_touch_at
	FROM page_visits
	GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source as 'source',
       lt_attr.utm_campaign as 'campaign',
       COUNT(*)
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;

5.
SELECT COUNT(page_name)
FROM page_visits
WHERE page_name = '4 - purchase';

6.
WITH last_touch AS (
	SELECT user_id, MAX(timestamp) as last_touch_at
	FROM page_visits
  WHERE page_name = '4 - purchase'
	GROUP BY user_id),
  lt_attr AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_source,
         pv.utm_campaign
  FROM last_touch lt
  JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source,
       lt_attr.utm_campaign,
       COUNT(*)
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;






