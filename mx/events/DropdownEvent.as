package mx.events
{
   import flash.events.Event;
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class DropdownEvent extends Event
   {
      public function DropdownEvent(param1:String, param2:Boolean=false, param3:Boolean=false, param4:Event=null) {
         super(param1,param2,param3);
         this.triggerEvent=param4;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const CLOSE:String = "close";

      public static const OPEN:String = "open";

      public var triggerEvent:Event;

      override public function clone() : Event {
         return new DropdownEvent(type,bubbles,cancelable,this.triggerEvent);
      }
   }

}