package mx.effects
{
   import flash.events.EventDispatcher;
   import mx.core.mx_internal;
   import flash.utils.Timer;
   import mx.utils.NameUtil;
   import flash.utils.getTimer;
   import flash.events.TimerEvent;
   import mx.effects.effectClasses.PropertyChanges;
   import flash.events.Event;
   import mx.events.FlexEvent;
   import mx.core.UIComponent;
   import mx.events.EffectEvent;
   import flash.events.IEventDispatcher;

   use namespace mx_internal;

   public class EffectInstance extends EventDispatcher implements IEffectInstance
   {
      public function EffectInstance(param1:Object) {
         super();
         this.target=param1;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal var delayTimer:Timer;

      private var delayStartTime:Number = 0;

      private var delayElapsedTime:Number = 0;

      mx_internal var durationExplicitlySet:Boolean = false;

      mx_internal var hideOnEffectEnd:Boolean = false;

      mx_internal var parentCompositeEffectInstance:EffectInstance;

      protected var playCount:int = 0;

      mx_internal var stopRepeat:Boolean = false;

      mx_internal function get actualDuration() : Number {
         var _loc1_:Number = NaN;
         if(this.repeatCount > 0)
         {
            _loc1_=this.duration * this.repeatCount + this.repeatDelay * (this.repeatCount-1) + this.startDelay;
         }
         return _loc1_;
      }

      public function get className() : String {
         return NameUtil.getUnqualifiedClassName(this);
      }

      private var _duration:Number = 500;

      public function get duration() : Number {
         if(!this.durationExplicitlySet && (this.parentCompositeEffectInstance))
         {
            return this.parentCompositeEffectInstance.duration;
         }
         return this._duration;
      }

      public function set duration(param1:Number) : void {
         this.durationExplicitlySet=true;
         this._duration=param1;
         return;
      }

      private var _effect:IEffect;

      public function get effect() : IEffect {
         return this._effect;
      }

      public function set effect(param1:IEffect) : void {
         this._effect=param1;
         return;
      }

      private var _effectTargetHost:IEffectTargetHost;

      public function get effectTargetHost() : IEffectTargetHost {
         return this._effectTargetHost;
      }

      public function set effectTargetHost(param1:IEffectTargetHost) : void {
         this._effectTargetHost=param1;
         return;
      }

      private var _hideFocusRing:Boolean;

      public function get hideFocusRing() : Boolean {
         return this._hideFocusRing;
      }

      public function set hideFocusRing(param1:Boolean) : void {
         this._hideFocusRing=param1;
         return;
      }

      public function get playheadTime() : Number {
         return Math.max(this.playCount-1,0) * (this.duration + this.repeatDelay) + (this.playReversed?0:this.startDelay);
      }

      public function set playheadTime(param1:Number) : void {
         if((this.delayTimer) && (this.delayTimer.running))
         {
            this.delayTimer.reset();
            if(param1 < this.startDelay)
            {
               this.delayTimer=new Timer(this.startDelay - param1,1);
               this.delayStartTime=getTimer();
               this.delayTimer.addEventListener(TimerEvent.TIMER,this.delayTimerHandler);
               this.delayTimer.start();
            }
            else
            {
               this.playCount=0;
               this.play();
            }
         }
         return;
      }

      private var _playReversed:Boolean;

      mx_internal function get playReversed() : Boolean {
         return this._playReversed;
      }

      mx_internal function set playReversed(param1:Boolean) : void {
         this._playReversed=param1;
         return;
      }

      private var _propertyChanges:PropertyChanges;

      public function get propertyChanges() : PropertyChanges {
         return this._propertyChanges;
      }

      public function set propertyChanges(param1:PropertyChanges) : void {
         this._propertyChanges=param1;
         return;
      }

      private var _repeatCount:int = 0;

      public function get repeatCount() : int {
         return this._repeatCount;
      }

      public function set repeatCount(param1:int) : void {
         this._repeatCount=param1;
         return;
      }

      private var _repeatDelay:int = 0;

      public function get repeatDelay() : int {
         return this._repeatDelay;
      }

      public function set repeatDelay(param1:int) : void {
         this._repeatDelay=param1;
         return;
      }

      private var _startDelay:int = 0;

      public function get startDelay() : int {
         return this._startDelay;
      }

      public function set startDelay(param1:int) : void {
         this._startDelay=param1;
         return;
      }

      private var _suspendBackgroundProcessing:Boolean = false;

      public function get suspendBackgroundProcessing() : Boolean {
         return this._suspendBackgroundProcessing;
      }

      public function set suspendBackgroundProcessing(param1:Boolean) : void {
         this._suspendBackgroundProcessing=param1;
         return;
      }

      private var _target:Object;

      public function get target() : Object {
         return this._target;
      }

      public function set target(param1:Object) : void {
         this._target=param1;
         return;
      }

      private var _triggerEvent:Event;

      public function get triggerEvent() : Event {
         return this._triggerEvent;
      }

      public function set triggerEvent(param1:Event) : void {
         this._triggerEvent=param1;
         return;
      }

      public function initEffect(param1:Event) : void {
         this.triggerEvent=param1;
         switch(param1.type)
         {
            case "resizeStart":
            case "resizeEnd":
               if(!this.durationExplicitlySet)
               {
                  this.duration=250;
               }
               break;
            case FlexEvent.HIDE:
               this.target.setVisible(true,true);
               this.hideOnEffectEnd=true;
               this.target.addEventListener(FlexEvent.SHOW,this.eventHandler);
               break;
         }
         return;
      }

      public function startEffect() : void {
         EffectManager.effectStarted(this);
         if(this.target  is  UIComponent)
         {
            UIComponent(this.target).effectStarted(this);
         }
         if(this.startDelay > 0 && !this.playReversed)
         {
            this.delayTimer=new Timer(this.startDelay,1);
            this.delayStartTime=getTimer();
            this.delayTimer.addEventListener(TimerEvent.TIMER,this.delayTimerHandler);
            this.delayTimer.start();
         }
         else
         {
            this.play();
         }
         return;
      }

      public function play() : void {
         this.playCount++;
         dispatchEvent(new EffectEvent(EffectEvent.EFFECT_START,false,false,this));
         if((this.target) && this.target  is  IEventDispatcher)
         {
            this.target.dispatchEvent(new EffectEvent(EffectEvent.EFFECT_START,false,false,this));
         }
         return;
      }

      public function pause() : void {
         if((this.delayTimer) && (this.delayTimer.running) && !isNaN(this.delayStartTime))
         {
            this.delayTimer.stop();
            this.delayElapsedTime=getTimer() - this.delayStartTime;
         }
         return;
      }

      public function stop() : void {
         if(this.delayTimer)
         {
            this.delayTimer.reset();
         }
         this.stopRepeat=true;
         dispatchEvent(new EffectEvent(EffectEvent.EFFECT_STOP,false,false,this));
         if((this.target) && this.target  is  IEventDispatcher)
         {
            this.target.dispatchEvent(new EffectEvent(EffectEvent.EFFECT_STOP,false,false,this));
         }
         this.finishEffect();
         return;
      }

      public function resume() : void {
         if((this.delayTimer) && (!this.delayTimer.running) && !isNaN(this.delayElapsedTime))
         {
            this.delayTimer.delay=!this.playReversed?this.delayTimer.delay - this.delayElapsedTime:this.delayElapsedTime;
            this.delayStartTime=getTimer();
            this.delayTimer.start();
         }
         return;
      }

      public function reverse() : void {
         if(this.repeatCount > 0)
         {
            this.playCount=this.repeatCount - this.playCount + 1;
         }
         return;
      }

      public function end() : void {
         if(this.delayTimer)
         {
            this.delayTimer.reset();
         }
         this.stopRepeat=true;
         this.finishEffect();
         return;
      }

      public function finishEffect() : void {
         this.playCount=0;
         dispatchEvent(new EffectEvent(EffectEvent.EFFECT_END,false,false,this));
         if((this.target) && this.target  is  IEventDispatcher)
         {
            this.target.dispatchEvent(new EffectEvent(EffectEvent.EFFECT_END,false,false,this));
         }
         if(this.target  is  UIComponent)
         {
            UIComponent(this.target).effectFinished(this);
         }
         EffectManager.effectFinished(this);
         return;
      }

      public function finishRepeat() : void {
         if(!this.stopRepeat && !(this.playCount == 0) && (this.playCount < this.repeatCount || this.repeatCount == 0))
         {
            if(this.repeatDelay > 0)
            {
               this.delayTimer=new Timer(this.repeatDelay,1);
               this.delayStartTime=getTimer();
               this.delayTimer.addEventListener(TimerEvent.TIMER,this.delayTimerHandler);
               this.delayTimer.start();
            }
            else
            {
               this.play();
            }
         }
         else
         {
            this.finishEffect();
         }
         return;
      }

      mx_internal function playWithNoDuration() : void {
         this.duration=0;
         this.repeatCount=1;
         this.repeatDelay=0;
         this.startDelay=0;
         this.startEffect();
         return;
      }

      mx_internal function eventHandler(param1:Event) : void {
         if(param1.type == FlexEvent.SHOW && this.hideOnEffectEnd == true)
         {
            this.hideOnEffectEnd=false;
            param1.target.removeEventListener(FlexEvent.SHOW,this.eventHandler);
         }
         return;
      }

      private function delayTimerHandler(param1:TimerEvent) : void {
         this.delayTimer.reset();
         this.delayStartTime=NaN;
         this.delayElapsedTime=NaN;
         this.play();
         return;
      }
   }

}