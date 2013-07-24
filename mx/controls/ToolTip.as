package mx.controls
{
   import mx.core.UIComponent;
   import mx.core.IToolTip;
   import mx.core.IFontContextComponent;
   import mx.core.mx_internal;
   import mx.core.IFlexDisplayObject;
   import mx.core.EdgeMetrics;
   import mx.core.IRectangularBorder;
   import mx.core.IFlexModuleFactory;
   import mx.core.IUITextField;
   import flash.text.TextFormat;
   import flash.display.DisplayObject;
   import mx.core.UITextField;
   import flash.text.TextFieldAutoSize;
   import mx.styles.ISimpleStyleClient;

   use namespace mx_internal;

   public class ToolTip extends UIComponent implements IToolTip, IFontContextComponent
   {
      public function ToolTip() {
         super();
         mouseEnabled=false;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static var maxWidth:Number = 300;

      mx_internal var border:IFlexDisplayObject;

      private function get borderMetrics() : EdgeMetrics {
         if(this.border  is  IRectangularBorder)
         {
            return IRectangularBorder(this.border).borderMetrics;
         }
         return EdgeMetrics.EMPTY;
      }

      public function get fontContext() : IFlexModuleFactory {
         return moduleFactory;
      }

      public function set fontContext(param1:IFlexModuleFactory) : void {
         this.moduleFactory=param1;
         return;
      }

      private var _text:String;

      private var textChanged:Boolean;

      public function get text() : String {
         return this._text;
      }

      public function set text(param1:String) : void {
         this._text=param1;
         this.textChanged=true;
         invalidateProperties();
         invalidateSize();
         invalidateDisplayList();
         return;
      }

      protected var textField:IUITextField;

      override protected function createChildren() : void {
         super.createChildren();
         this.createBorder();
         this.createTextField(-1);
         return;
      }

      override protected function commitProperties() : void {
         var _loc1_:* = 0;
         var _loc2_:TextFormat = null;
         super.commitProperties();
         if((hasFontContextChanged()) && !(this.textField == null))
         {
            _loc1_=getChildIndex(DisplayObject(this.textField));
            this.removeTextField();
            this.createTextField(_loc1_);
            invalidateSize();
            this.textChanged=true;
         }
         if(this.textChanged)
         {
            _loc2_=this.textField.getTextFormat();
            _loc2_.leftMargin=0;
            _loc2_.rightMargin=0;
            this.textField.defaultTextFormat=_loc2_;
            this.textField.text=this._text;
            this.textChanged=false;
         }
         return;
      }

      override protected function measure() : void {
         super.measure();
         var _loc1_:EdgeMetrics = this.borderMetrics;
         var _loc2_:Number = _loc1_.left + getStyle("paddingLeft");
         var _loc3_:Number = _loc1_.top + getStyle("paddingTop");
         var _loc4_:Number = _loc1_.right + getStyle("paddingRight");
         var _loc5_:Number = _loc1_.bottom + getStyle("paddingBottom");
         var _loc6_:Number = _loc2_ + _loc4_;
         var _loc7_:Number = _loc3_ + _loc5_;
         this.textField.wordWrap=false;
         if(this.textField.textWidth + _loc6_ > ToolTip.maxWidth)
         {
            this.textField.width=ToolTip.maxWidth - _loc6_;
            this.textField.wordWrap=true;
         }
         measuredWidth=this.textField.width + _loc6_;
         measuredHeight=this.textField.height + _loc7_;
         return;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         var _loc3_:EdgeMetrics = this.borderMetrics;
         var _loc4_:Number = _loc3_.left + getStyle("paddingLeft");
         var _loc5_:Number = _loc3_.top + getStyle("paddingTop");
         var _loc6_:Number = _loc3_.right + getStyle("paddingRight");
         var _loc7_:Number = _loc3_.bottom + getStyle("paddingBottom");
         var _loc8_:Number = _loc4_ + _loc6_;
         var _loc9_:Number = _loc5_ + _loc7_;
         this.border.setActualSize(param1,param2);
         this.textField.move(_loc4_,_loc5_);
         this.textField.setActualSize(param1 - _loc8_,param2 - _loc9_);
         return;
      }

      override public function styleChanged(param1:String) : void {
         super.styleChanged(param1);
         if(param1 == "styleName" || param1 == "borderSkin" || param1 == null)
         {
            if(this.border)
            {
               removeChild(DisplayObject(this.border));
               this.border=null;
            }
            this.createBorder();
         }
         else
         {
            if(param1 == "borderStyle")
            {
               invalidateDisplayList();
            }
         }
         return;
      }

      mx_internal function createTextField(param1:int) : void {
         if(!this.textField)
         {
            this.textField=IUITextField(createInFontContext(UITextField));
            this.textField.autoSize=TextFieldAutoSize.LEFT;
            this.textField.mouseEnabled=false;
            this.textField.multiline=true;
            this.textField.selectable=false;
            this.textField.wordWrap=false;
            this.textField.styleName=this;
            if(param1 == -1)
            {
               addChild(DisplayObject(this.textField));
            }
            else
            {
               addChildAt(DisplayObject(this.textField),param1);
            }
         }
         return;
      }

      mx_internal function removeTextField() : void {
         if(this.textField)
         {
            removeChild(DisplayObject(this.textField));
            this.textField=null;
         }
         return;
      }

      mx_internal function getTextField() : IUITextField {
         return this.textField;
      }

      private function createBorder() : void {
         var _loc1_:Class = null;
         if(!this.border)
         {
            _loc1_=getStyle("borderSkin");
            if(_loc1_ != null)
            {
               this.border=new _loc1_();
               if(this.border  is  ISimpleStyleClient)
               {
                  ISimpleStyleClient(this.border).styleName=this;
               }
               addChildAt(DisplayObject(this.border),0);
               invalidateDisplayList();
            }
         }
         return;
      }
   }

}