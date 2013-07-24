package mx.filters
{
   import flash.events.EventDispatcher;
   import flash.events.Event;
   import flash.events.IEventDispatcher;


   public class BaseFilter extends EventDispatcher
   {
      public function BaseFilter(param1:IEventDispatcher=null) {
         super(param1);
         return;
      }

      public static const CHANGE:String = "change";

      public function notifyFilterChanged() : void {
         dispatchEvent(new Event(CHANGE));
         return;
      }
   }

}