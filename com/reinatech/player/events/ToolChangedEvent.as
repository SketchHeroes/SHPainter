package com.reinatech.player.events
{
   import flash.events.Event;


   public class ToolChangedEvent extends Event
   {
      public function ToolChangedEvent(param1:String, param2:Boolean, param3:Boolean, param4:String, param5:int) {
         super(param1,param2,param3);
         this._toolClassName=param4;
         this._toolIndex=param5;
         return;
      }

      public static const ActiveToolChanged:String = "activeToolChanged";

      private var _toolClassName:String;

      private var _toolIndex:int;

      public function get toolClassName() : String {
         return this._toolClassName;
      }

      public function get toolIndex() : int {
         return this._toolIndex;
      }

      override public function clone() : Event {
         return new ToolChangedEvent(type,bubbles,cancelable,this._toolClassName,this._toolIndex);
      }
   }

}