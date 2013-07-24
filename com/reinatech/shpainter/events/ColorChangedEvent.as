package com.reinatech.shpainter.events
{
   import flash.events.Event;


   public class ColorChangedEvent extends Event
   {
      public function ColorChangedEvent(param1:String, param2:Boolean, param3:Boolean, param4:uint) {
         super(param1,param2,param3);
         this._color=param4;
         return;
      }

      public static const CHANGE:String = "change";

      private var _color:uint;

      public function get color() : uint {
         return this._color;
      }

      override public function clone() : Event {
         return new ColorChangedEvent(type,bubbles,cancelable,this._color);
      }
   }

}