package com.reinatech.shpainter.events
{
   import flash.events.Event;


   public class BrushChangedEvent extends Event
   {
      public function BrushChangedEvent(param1:String, param2:Boolean, param3:Boolean, param4:int) {
         super(param1,param2,param3);
         this._brushIndex=param4;
         return;
      }

      public static const CHANGE:String = "change";

      private var _brushIndex:int;

      public function get brushIndex() : int {
         return this._brushIndex;
      }

      override public function clone() : Event {
         return new BrushChangedEvent(type,bubbles,cancelable,this._brushIndex);
      }
   }

}