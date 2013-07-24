package com.reinatech.player.events
{
   import flash.events.Event;


   public class AnimationFinishedEvent extends Event
   {
      public function AnimationFinishedEvent(param1:String, param2:Boolean, param3:Boolean) {
         super(param1,param2,param3);
         return;
      }

      public static const CHANGE:String = "animationFinished";

      override public function clone() : Event {
         return new AnimationFinishedEvent(type,bubbles,cancelable);
      }
   }

}