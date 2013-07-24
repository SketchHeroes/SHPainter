package mx.events
{
   import flash.events.Event;
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class ResizeEvent extends Event
   {
      public function ResizeEvent(param1:String, param2:Boolean=false, param3:Boolean=false, param4:Number=NaN, param5:Number=NaN) {
         super(param1,param2,param3);
         this.oldWidth=param4;
         this.oldHeight=param5;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const RESIZE:String = "resize";

      public var oldHeight:Number;

      public var oldWidth:Number;

      override public function clone() : Event {
         return new ResizeEvent(type,bubbles,cancelable,this.oldWidth,this.oldHeight);
      }
   }

}