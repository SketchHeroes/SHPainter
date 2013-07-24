package mx.controls.sliderClasses
{
   import mx.controls.Button;
   import mx.core.mx_internal;
   import mx.core.FlexVersion;
   import mx.controls.ButtonPhase;
   import flash.events.MouseEvent;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import flash.geom.Point;

   use namespace mx_internal;

   public class SliderThumb extends Button
   {
      public function SliderThumb() {
         super();
         stickyHighlighting=true;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal var thumbIndex:int;

      private var xOffset:Number;

      override public function set x(param1:Number) : void {
         var _loc2_:Number = this.moveXPos(param1);
         this.updateValue();
         super.x=_loc2_;
         return;
      }

      public function get xPosition() : Number {
         return $x + width / 2;
      }

      public function set xPosition(param1:Number) : void {
         $x=param1 - width / 2;
         Slider(owner).drawTrackHighlight();
         return;
      }

      override protected function measure() : void {
         super.measure();
         if(FlexVersion.compatibilityVersion < FlexVersion.VERSION_4_0)
         {
            measuredWidth=12;
            measuredHeight=12;
         }
         return;
      }

      override public function drawFocus(param1:Boolean) : void {
         phase=param1?ButtonPhase.DOWN:ButtonPhase.UP;
         return;
      }

      override mx_internal function buttonReleased() : void {
         super.buttonReleased();
         if(enabled)
         {
            systemManager.getSandboxRoot().removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler,true);
            systemManager.deployMouseShields(false);
            Slider(owner).onThumbRelease(this);
         }
         return;
      }

      private function moveXPos(param1:Number, param2:Boolean=false, param3:Boolean=false) : Number {
         var _loc4_:Number = this.calculateXPos(param1,param2);
         this.xPosition=_loc4_;
         if(!param3)
         {
            this.updateValue();
         }
         return _loc4_;
      }

      private function calculateXPos(param1:Number, param2:Boolean=false) : Number {
         var _loc3_:Object = Slider(owner).getXBounds(this.thumbIndex);
         var _loc4_:Number = Math.min(Math.max(param1,_loc3_.min),_loc3_.max);
         if(!param2)
         {
            _loc4_=Slider(owner).getSnapValue(_loc4_,this);
         }
         return _loc4_;
      }

      mx_internal function onTweenUpdate(param1:Number) : void {
         this.moveXPos(param1,true,true);
         return;
      }

      mx_internal function onTweenEnd(param1:Number) : void {
         this.moveXPos(param1);
         return;
      }

      private function updateValue() : void {
         Slider(owner).updateThumbValue(this.thumbIndex);
         return;
      }

      override protected function keyDownHandler(param1:KeyboardEvent) : void {
         var _loc6_:* = NaN;
         var _loc2_:* = Slider(owner).thumbCount > 1;
         var _loc3_:Number = this.xPosition;
         var _loc4_:Number = Slider(owner).snapInterval > 0?Slider(owner).getSnapIntervalWidth():1;
         var _loc5_:* = Slider(owner).direction == SliderDirection.HORIZONTAL;
         var _loc7_:uint = mapKeycodeForLayoutDirection(param1);
         if(_loc7_ == Keyboard.DOWN && !_loc5_ || _loc7_ == Keyboard.LEFT && (_loc5_))
         {
            _loc6_=_loc3_ - _loc4_;
         }
         else
         {
            if(_loc7_ == Keyboard.UP && !_loc5_ || _loc7_ == Keyboard.RIGHT && (_loc5_))
            {
               _loc6_=_loc3_ + _loc4_;
            }
            else
            {
               if(_loc7_ == Keyboard.PAGE_DOWN && !_loc5_ || _loc7_ == Keyboard.HOME && (_loc5_))
               {
                  _loc6_=Slider(owner).getXFromValue(Slider(owner).minimum);
               }
               else
               {
                  if(_loc7_ == Keyboard.PAGE_UP && !_loc5_ || _loc7_ == Keyboard.END && (_loc5_))
                  {
                     _loc6_=Slider(owner).getXFromValue(Slider(owner).maximum);
                  }
               }
            }
         }
         if(!isNaN(_loc6_))
         {
            param1.stopPropagation();
            Slider(owner).keyInteraction=true;
            this.moveXPos(_loc6_);
         }
         return;
      }

      override protected function mouseDownHandler(param1:MouseEvent) : void {
         super.mouseDownHandler(param1);
         if(enabled)
         {
            this.xOffset=param1.localX;
            systemManager.getSandboxRoot().addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler,true);
            systemManager.deployMouseShields(true);
            Slider(owner).onThumbPress(this);
         }
         return;
      }

      private function mouseMoveHandler(param1:MouseEvent) : void {
         var _loc2_:Point = null;
         if(enabled)
         {
            _loc2_=new Point(param1.stageX,param1.stageY);
            _loc2_=Slider(owner).innerSlider.globalToLocal(_loc2_);
            this.moveXPos(_loc2_.x - this.xOffset + width / 2,false,true);
            Slider(owner).onThumbMove(this);
         }
         return;
      }
   }

}