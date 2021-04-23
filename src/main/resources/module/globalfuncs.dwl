 %dw 2.0
 import java!java::util::Base64
 import java!java::lang::System
 import java!java::lang::String
 import java!java::util::Calendar
 import java!java::util::TimeZone
 
//fun encode(value:String) = { encoded: (String::new(Base64::getUrlEncoder().encode( value.getBytes() ) ) ) }
 
fun getSecondsSince1970UTC() = {value: (System::currentTimeMillis() / 1000 + 5 * 3600 )as Number}


 