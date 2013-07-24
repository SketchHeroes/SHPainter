package mx.events
{
   import flash.events.Event;
   import mx.core.mx_internal;

   use namespace mx_internal;

   public class ScrollEvent extends Event
   {
      public function ScrollEvent(param1:String, param2:Boolean=false, param3:Boolean=false, param4:String=null, param5:Number=NaN, param6:String=null, param7:Number=NaN) {
         super(param1,param2,param3);
         this.detail=param4;
         this.position=param5;
         this.direction=param6;
         this.delta=param7;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const SCROLL:String = "scroll";

      public var delta:Number;

      public var detail:String;

      public var direction:String;

      public var position:Number;

      override public function clone() : Event {
         return new ScrollEvent(type,bubbles,cancelable,this.detail,this.position,this.direction,this.delta);
      }
   }

}