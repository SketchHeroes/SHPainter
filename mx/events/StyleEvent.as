package mx.events
{
   import flash.events.ProgressEvent;
   import mx.core.mx_internal;
   import flash.events.Event;

   use namespace mx_internal;

   public class StyleEvent extends ProgressEvent
   {
      public function StyleEvent(param1:String, param2:Boolean=false, param3:Boolean=false, param4:uint=0, param5:uint=0, param6:String=null) {
         super(param1,param2,param3,param4,param5);
         this.errorText=param6;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const COMPLETE:String = "complete";

      public static const ERROR:String = "error";

      public static const PROGRESS:String = "progress";

      public var errorText:String;

      override public function clone() : Event {
         return new StyleEvent(type,bubbles,cancelable,bytesLoaded,bytesTotal,this.errorText);
      }
   }

}