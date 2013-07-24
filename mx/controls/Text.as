package mx.controls
{
   import mx.core.mx_internal;
   import mx.core.UITextField;
   import mx.events.FlexEvent;

   use namespace mx_internal;

   public class Text extends Label
   {
      public function Text() {
         super();
         selectable=true;
         truncateToFit=false;
         addEventListener(FlexEvent.UPDATE_COMPLETE,this.updateCompleteHandler);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var lastUnscaledWidth:Number = NaN;

      private var widthChanged:Boolean = true;

      override public function set explicitWidth(param1:Number) : void {
         if(param1 != explicitWidth)
         {
            this.widthChanged=true;
            invalidateProperties();
            invalidateSize();
         }
         super.explicitWidth=param1;
         return;
      }

      override public function set maxWidth(param1:Number) : void {
         if(param1 != maxWidth)
         {
            this.widthChanged=true;
            invalidateProperties();
            invalidateSize();
         }
         super.maxWidth=param1;
         return;
      }

      override public function set percentWidth(param1:Number) : void {
         if(param1 != percentWidth)
         {
            this.widthChanged=true;
            invalidateProperties();
            invalidateSize();
         }
         super.percentWidth=param1;
         return;
      }

      override protected function childrenCreated() : void {
         super.childrenCreated();
         textField.wordWrap=true;
         textField.multiline=true;
         textField.mouseWheelEnabled=false;
         return;
      }

      override protected function commitProperties() : void {
         super.commitProperties();
         if(this.widthChanged)
         {
            textField.wordWrap=!isNaN(explicitWidth) || !isNaN(explicitMaxWidth) || !isNaN(percentWidth);
            this.widthChanged=false;
         }
         return;
      }

      override protected function measure() : void {
         var _loc1_:* = NaN;
         if(this.isSpecialCase())
         {
            if(!isNaN(this.lastUnscaledWidth))
            {
               this.measureUsingWidth(this.lastUnscaledWidth);
            }
            else
            {
               measuredWidth=0;
               measuredHeight=0;
            }
            return;
         }
         if(!isNaN(explicitWidth))
         {
            _loc1_=explicitWidth;
         }
         else
         {
            if(!isNaN(explicitMaxWidth))
            {
               _loc1_=explicitMaxWidth;
            }
         }
         this.measureUsingWidth(_loc1_);
         return;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         var _loc7_:* = false;
         if(this.isSpecialCase())
         {
            _loc7_=(isNaN(this.lastUnscaledWidth)) || !(this.lastUnscaledWidth == param1);
            this.lastUnscaledWidth=param1;
            if(_loc7_)
            {
               invalidateSize();
               return;
            }
         }
         var _loc3_:Number = getStyle("paddingLeft");
         var _loc4_:Number = getStyle("paddingTop");
         var _loc5_:Number = getStyle("paddingRight");
         var _loc6_:Number = getStyle("paddingBottom");
         textField.setActualSize(param1 - _loc3_ - _loc5_,param2 - _loc4_ - _loc6_);
         textField.x=_loc3_;
         textField.y=_loc4_;
         if(Math.floor(width) < Math.floor(measuredWidth))
         {
            textField.wordWrap=true;
         }
         return;
      }

      private function isSpecialCase() : Boolean {
         var _loc1_:Number = getStyle("left");
         var _loc2_:Number = getStyle("right");
         return (!isNaN(percentWidth) || !isNaN(_loc1_) && !isNaN(_loc2_)) && (isNaN(explicitHeight)) && (isNaN(percentHeight));
      }

      private function measureUsingWidth(param1:Number) : void {
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = false;
         var _loc2_:Number = getStyle("paddingLeft");
         var _loc3_:Number = getStyle("paddingTop");
         _loc4_=getStyle("paddingRight");
         _loc5_=getStyle("paddingBottom");
         textField.validateNow();
         textField.autoSize="left";
         if(!isNaN(param1))
         {
            textField.width=param1 - _loc2_ - _loc4_;
            measuredWidth=Math.ceil(textField.textWidth) + UITextField.TEXT_WIDTH_PADDING;
            measuredHeight=Math.ceil(textField.textHeight) + UITextField.TEXT_HEIGHT_PADDING;
         }
         else
         {
            _loc6_=textField.wordWrap;
            textField.wordWrap=false;
            measuredWidth=Math.ceil(textField.textWidth) + UITextField.TEXT_WIDTH_PADDING;
            measuredHeight=Math.ceil(textField.textHeight) + UITextField.TEXT_HEIGHT_PADDING;
            textField.wordWrap=_loc6_;
         }
         textField.autoSize="none";
         measuredWidth=measuredWidth + (_loc2_ + _loc4_);
         measuredHeight=measuredHeight + (_loc3_ + _loc5_);
         if(isNaN(explicitWidth))
         {
            measuredMinWidth=DEFAULT_MEASURED_MIN_WIDTH;
            measuredMinHeight=DEFAULT_MEASURED_MIN_HEIGHT;
         }
         else
         {
            measuredMinWidth=measuredWidth;
            measuredMinHeight=measuredHeight;
         }
         return;
      }

      private function updateCompleteHandler(param1:FlexEvent) : void {
         this.lastUnscaledWidth=NaN;
         return;
      }
   }

}