## tomcat access_log日志格式

1. [Attributes](http://tomcat.apache.org/tomcat-7.0-doc/config/valve.html#Access_Log_Valve/Attributes)

+ %a - Remote IP address
+ %A - Local IP address
+ %b - Bytes sent, excluding HTTP headers, or '-' if zero
+ %B - Bytes sent, excluding HTTP headers
+ %h - Remote host name (or IP address if enableLookups for the connector is false)
+ %H - Request protocol
+ %l - Remote logical username from identd (always returns '-')
+ %m - Request method (GET, POST, etc.)
+ %p - Local port on which this request was received. See also %{xxx}p below.
+ %q - Query string (prepended with a '?' if it exists)
+ %r - First line of the request (method and request URI)
+ %s - HTTP status code of the response
+ %S - User session ID
+ %t - Date and time, in Common Log Format
+ %u - Remote user that was authenticated (if any), else '-'
+ %U - Requested URL path
+ %v - Local server name
+ %D - Time taken to process the request, in millis
+ %T - Time taken to process the request, in seconds
+ %F - Time taken to commit the response, in millis
+ %I - Current request thread name (can compare later with stacktraces)
