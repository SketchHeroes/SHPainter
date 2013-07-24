package mx.effects.effectClasses
{
   import mx.core.mx_internal;
   import flash.events.Event;
   import mx.events.FlexEvent;

   use namespace mx_internal;

   public class FadeInstance extends TweenEffectInstance
   {
      public function FadeInstance(param1:Object) {
         super(param1);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var origAlpha:Number = NaN;

      private var restoreAlpha:Boolean;

      public var alphaFrom:Number;

      public var alphaTo:Number;

      override public function initEffect(param1:Event) : void {
         super.initEffect(param1);
         switch(param1.type)
         {
            case "childrenCreationComplete":
            case FlexEvent.CREATION_COMPLETE:
            case FlexEvent.SHOW:
            case Event.ADDED:
            case "resizeEnd":
               if(isNaN(this.alphaFrom))
               {
                  this.alphaFrom=0;
               }
               if(isNaN(this.alphaTo))
               {
                  this.alphaTo=target.alpha;
               }
               break;
            case FlexEvent.HIDE:
            case Event.REMOVED:
            case "resizeStart":
               this.restoreAlpha=true;
               if(isNaN(this.alphaFrom))
               {
                  this.alphaFrom=target.alpha;
               }
               if(isNaN(this.alphaTo))
               {
                  this.alphaTo=0;
               }
               break;
         }
         return;
      }

      override public function play() : void {
         super.play();
         this.origAlpha=target.alpha;
         var _loc1_:PropertyChanges = propertyChanges;
         if((isNaN(this.alphaFrom)) && (isNaN(this.alphaTo)))
         {
            if((_loc1_) && !(_loc1_.end["alpha"] === undefined))
            {
               this.alphaFrom=this.origAlpha;
               this.alphaTo=_loc1_.end["alpha"];
            }
            else
            {
               if((_loc1_) && !(_loc1_.end["visible"] === undefined))
               {
                  this.alphaFrom=_loc1_.start["visible"]?this.origAlpha:0;
                  this.alphaTo=_loc1_.end["visible"]?this.origAlpha:0;
               }
               else
               {
                  this.alphaFrom=0;
                  this.alphaTo=this.origAlpha;
               }
            }
         }
         else
         {
            if(isNaN(this.alphaFrom))
            {
               this.alphaFrom=this.alphaTo == 0?this.origAlpha:0;
            }
            else
            {
               if(isNaN(this.alphaTo))
               {
                  if((_loc1_) && !(_loc1_.end["alpha"] === undefined))
                  {
                     this.alphaTo=_loc1_.end["alpha"];
                  }
                  else
                  {
                     this.alphaTo=this.alphaFrom == 0?this.origAlpha:0;
                  }
               }
            }
         }
         tween=createTween(this,this.alphaFrom,this.alphaTo,duration);
         target.alpha=tween.getCurrentValue(0);
         return;
      }

      override public function onTweenUpdate(param1:Object) : void {
         target.alpha=param1;
         return;
      }

      override public function onTweenEnd(param1:Object) : void {
         super.onTweenEnd(param1);
         if((hideOnEffectEnd) || (this.restoreAlpha))
         {
            target.alpha=this.origAlpha;
         }
         return;
      }
   }

}