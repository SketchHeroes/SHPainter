package mx.events
{
   import flash.events.Event;
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class ValidationResultEvent extends Event
   {
      public function ValidationResultEvent(param1:String, param2:Boolean=false, param3:Boolean=false, param4:String=null, param5:Array=null) {
         super(param1,param2,param3);
         this.field=param4;
         this.results=param5;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const INVALID:String = "invalid";

      public static const VALID:String = "valid";

      public var field:String;

      public function get message() : String {
         var _loc1_:* = "";
         var _loc2_:int = this.results.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            if(this.results[_loc3_].isError)
            {
               _loc1_=_loc1_ + ("");
               _loc1_=_loc1_ + this.results[_loc3_].errorMessage;
            }
            _loc3_++;
         }
         return _loc1_;
      }

      public var results:Array;

      override public function clone() : Event {
         return new ValidationResultEvent(type,bubbles,cancelable,this.field,this.results);
      }
   }

}