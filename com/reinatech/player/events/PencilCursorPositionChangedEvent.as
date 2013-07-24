package com.reinatech.player.events
{
   import flash.events.Event;
   import flash.geom.Point;


   public class PencilCursorPositionChangedEvent extends Event
   {
      public function PencilCursorPositionChangedEvent(param1:String, param2:Boolean, param3:Boolean, param4:Point) {
         super(param1,param2,param3);
         this._position=param4;
         return;
      }

      public static const CHANGE:String = "pencilCursorPositionChanged";

      private var _position:Point;

      public function get position() : Point {
         return this._position;
      }

      override public function clone() : Event {
         return new PencilCursorPositionChangedEvent(type,bubbles,cancelable,this._position);
      }
   }

}