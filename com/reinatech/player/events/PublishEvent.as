package com.reinatech.player.events
{
   import flash.events.Event;


   public class PublishEvent extends Event
   {
      public function PublishEvent(param1:String, param2:Boolean, param3:Boolean, param4:String, param5:String, param6:String) {
         super(param1,param2,param3);
         this._title=param4;
         this._description=param5;
         this._category=param6;
         return;
      }

      public static const PUBLISH:String = "publish";

      private var _title:String;

      private var _description:String;

      private var _category:String;

      public function get title() : String {
         return this._title;
      }

      public function get description() : String {
         return this._description;
      }

      public function get category() : String {
         return this._category;
      }

      override public function clone() : Event {
         return new PublishEvent(type,bubbles,cancelable,this._title,this._description,this._category);
      }
   }

}