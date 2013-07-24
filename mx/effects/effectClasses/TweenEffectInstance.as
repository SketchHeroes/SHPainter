package mx.effects.effectClasses
{
   import mx.effects.EffectInstance;
   import mx.core.mx_internal;
   import mx.effects.Tween;
   import mx.events.TweenEvent;
   import mx.core.UIComponentGlobals;

   use namespace mx_internal;

   public class TweenEffectInstance extends EffectInstance
   {
      public function TweenEffectInstance(param1:Object) {
         super(param1);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal var needToLayout:Boolean = false;

      private var _seekTime:Number = 0;

      public var easingFunction:Function;

      override mx_internal function set playReversed(param1:Boolean) : void {
         super.playReversed=param1;
         if(this.tween)
         {
            this.tween.playReversed=param1;
         }
         return;
      }

      override public function get playheadTime() : Number {
         if(this.tween)
         {
            return this.tween.playheadTime + super.playheadTime;
         }
         return 0;
      }

      override public function set playheadTime(param1:Number) : void {
         if(this.tween)
         {
            this.tween.seek(param1);
         }
         else
         {
            this._seekTime=param1;
         }
         return;
      }

      public var tween:Tween;

      override public function pause() : void {
         super.pause();
         if(this.tween)
         {
            this.tween.pause();
         }
         return;
      }

      override public function stop() : void {
         super.stop();
         if(this.tween)
         {
            this.tween.stop();
         }
         return;
      }

      override public function resume() : void {
         super.resume();
         if(this.tween)
         {
            this.tween.resume();
         }
         return;
      }

      override public function reverse() : void {
         super.reverse();
         if(this.tween)
         {
            this.tween.reverse();
         }
         super.playReversed=!playReversed;
         return;
      }

      override public function end() : void {
         stopRepeat=true;
         if(delayTimer)
         {
            delayTimer.reset();
         }
         if(this.tween)
         {
            this.tween.endTween();
            this.tween=null;
         }
         return;
      }

      protected function createTween(param1:Object, param2:Object, param3:Object, param4:Number=-1, param5:Number=-1) : Tween {
         var _loc6_:Tween = new Tween(param1,param2,param3,param4,param5);
         _loc6_.addEventListener(TweenEvent.TWEEN_START,this.tweenEventHandler);
         _loc6_.addEventListener(TweenEvent.TWEEN_UPDATE,this.tweenEventHandler);
         _loc6_.addEventListener(TweenEvent.TWEEN_END,this.tweenEventHandler);
         if(this.easingFunction != null)
         {
            _loc6_.easingFunction=this.easingFunction;
         }
         if(this._seekTime > 0)
         {
            _loc6_.seek(this._seekTime);
         }
         _loc6_.playReversed=playReversed;
         return _loc6_;
      }

      mx_internal function applyTweenStartValues() : void {
         if(duration > 0)
         {
            this.onTweenUpdate(this.tween.getCurrentValue(0));
         }
         return;
      }

      private function tweenEventHandler(param1:TweenEvent) : void {
         dispatchEvent(param1);
         return;
      }

      public function onTweenUpdate(param1:Object) : void {
         return;
      }

      public function onTweenEnd(param1:Object) : void {
         this.onTweenUpdate(param1);
         this.tween=null;
         if(this.needToLayout)
         {
            UIComponentGlobals.layoutManager.validateNow();
         }
         finishRepeat();
         return;
      }
   }

}