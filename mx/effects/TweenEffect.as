package mx.effects
{
   import mx.core.mx_internal;
   import mx.effects.effectClasses.TweenEffectInstance;
   import flash.events.EventDispatcher;
   import mx.events.TweenEvent;

   use namespace mx_internal;

   public class TweenEffect extends Effect
   {
      public function TweenEffect(param1:Object=null) {
         super(param1);
         instanceClass=TweenEffectInstance;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public var easingFunction:Function = null;

      override protected function initInstance(param1:IEffectInstance) : void {
         super.initInstance(param1);
         TweenEffectInstance(param1).easingFunction=this.easingFunction;
         EventDispatcher(param1).addEventListener(TweenEvent.TWEEN_START,this.tweenEventHandler);
         EventDispatcher(param1).addEventListener(TweenEvent.TWEEN_UPDATE,this.tweenEventHandler);
         EventDispatcher(param1).addEventListener(TweenEvent.TWEEN_END,this.tweenEventHandler);
         return;
      }

      protected function tweenEventHandler(param1:TweenEvent) : void {
         dispatchEvent(param1);
         return;
      }
   }

}