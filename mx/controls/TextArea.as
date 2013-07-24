package mx.controls
{
   import mx.core.ScrollControlBase;
   import mx.core.IDataRenderer;
   import mx.controls.listClasses.IDropInListItemRenderer;
   import mx.managers.IFocusManagerComponent;
   import mx.core.IIMESupport;
   import mx.controls.listClasses.IListItemRenderer;
   import mx.core.IFontContextComponent;
   import mx.core.mx_internal;
   import flash.accessibility.AccessibilityProperties;
   import mx.core.IInvalidating;
   import mx.core.IFlexModuleFactory;
   import mx.core.ScrollPolicy;
   import mx.core.IUITextField;
   import flash.events.Event;
   import mx.events.FlexEvent;
   import mx.controls.listClasses.BaseListData;
   import flash.text.StyleSheet;
   import flash.text.TextFieldType;
   import mx.core.EdgeMetrics;
   import flash.display.DisplayObject;
   import mx.core.UITextField;
   import flash.text.TextFieldAutoSize;
   import flash.events.IOErrorEvent;
   import flash.events.TextEvent;
   import flash.text.TextLineMetrics;
   import flash.events.FocusEvent;
   import mx.managers.IFocusManager;
   import flash.text.TextField;
   import flash.system.IME;
   import flash.system.IMEConversionMode;
   import flash.events.MouseEvent;
   import mx.events.ScrollEvent;
   import mx.events.ScrollEventDetail;
   import mx.events.ScrollEventDirection;

   use namespace mx_internal;

   public class TextArea extends ScrollControlBase implements IDataRenderer, IDropInListItemRenderer, IFocusManagerComponent, IIMESupport, IListItemRenderer, IFontContextComponent
   {
      public function TextArea() {
         super();
         _horizontalScrollPolicy=ScrollPolicy.AUTO;
         _verticalScrollPolicy=ScrollPolicy.AUTO;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var allowScrollEvent:Boolean = true;

      private var textSet:Boolean;

      private var selectionChanged:Boolean = false;

      private var errorCaught:Boolean = false;

      private var _accessibilityProperties:AccessibilityProperties;

      private var accessibilityPropertiesChanged:Boolean = false;

      override public function get accessibilityProperties() : AccessibilityProperties {
         return this._accessibilityProperties;
      }

      override public function set accessibilityProperties(param1:AccessibilityProperties) : void {
         if(param1 == this._accessibilityProperties)
         {
            return;
         }
         this._accessibilityProperties=param1;
         this.accessibilityPropertiesChanged=true;
         invalidateProperties();
         return;
      }

      override public function get baselinePosition() : Number {
         if(!validateBaselinePosition())
         {
            return NaN;
         }
         return this.textField.y + this.textField.baselinePosition;
      }

      private var enabledChanged:Boolean = false;

      override public function set enabled(param1:Boolean) : void {
         if(param1 == enabled)
         {
            return;
         }
         super.enabled=param1;
         this.enabledChanged=true;
         if(verticalScrollBar)
         {
            verticalScrollBar.enabled=param1;
         }
         if(horizontalScrollBar)
         {
            horizontalScrollBar.enabled=param1;
         }
         invalidateProperties();
         if((border) && border  is  IInvalidating)
         {
            IInvalidating(border).invalidateDisplayList();
         }
         return;
      }

      public function get fontContext() : IFlexModuleFactory {
         return moduleFactory;
      }

      public function set fontContext(param1:IFlexModuleFactory) : void {
         this.moduleFactory=param1;
         return;
      }

      private var _hScrollPosition:Number;

      override public function set horizontalScrollPosition(param1:Number) : void {
         super.horizontalScrollPosition=param1;
         this._hScrollPosition=param1;
         if(this.textField)
         {
            this.textField.scrollH=param1;
            this.textField.background=false;
         }
         else
         {
            invalidateProperties();
         }
         return;
      }

      override public function get horizontalScrollPolicy() : String {
         return height <= 40?ScrollPolicy.OFF:_horizontalScrollPolicy;
      }

      override public function get maxHorizontalScrollPosition() : Number {
         return this.textField?this.textField.maxScrollH:0;
      }

      override public function get maxVerticalScrollPosition() : Number {
         return this.textField?this.textField.maxScrollV-1:0;
      }

      private var _tabIndex:int = -1;

      private var tabIndexChanged:Boolean = false;

      override public function get tabIndex() : int {
         return this._tabIndex;
      }

      override public function set tabIndex(param1:int) : void {
         if(param1 == this._tabIndex)
         {
            return;
         }
         this._tabIndex=param1;
         this.tabIndexChanged=true;
         invalidateProperties();
         return;
      }

      protected var textField:IUITextField;

      private var _vScrollPosition:Number;

      override public function set verticalScrollPosition(param1:Number) : void {
         super.verticalScrollPosition=param1;
         this._vScrollPosition=param1;
         if(this.textField)
         {
            this.textField.scrollV=param1 + 1;
            this.textField.background=false;
         }
         else
         {
            invalidateProperties();
         }
         return;
      }

      override public function get verticalScrollPolicy() : String {
         return height <= 40?ScrollPolicy.OFF:_verticalScrollPolicy;
      }

      private var _condenseWhite:Boolean = false;

      private var condenseWhiteChanged:Boolean = false;

      public function get condenseWhite() : Boolean {
         return this._condenseWhite;
      }

      public function set condenseWhite(param1:Boolean) : void {
         if(param1 == this._condenseWhite)
         {
            return;
         }
         this._condenseWhite=param1;
         this.condenseWhiteChanged=true;
         if(this.isHTML)
         {
            this.htmlTextChanged=true;
         }
         invalidateProperties();
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("condenseWhiteChanged"));
         return;
      }

      private var _data:Object;

      public function get data() : Object {
         return this._data;
      }

      public function set data(param1:Object) : void {
         var _loc2_:* = undefined;
         this._data=param1;
         if(this._listData)
         {
            _loc2_=this._listData.label;
         }
         else
         {
            if(this._data != null)
            {
               if(this._data  is  String)
               {
                  _loc2_=String(this._data);
               }
               else
               {
                  _loc2_=this._data.toString();
               }
            }
         }
         if(!(_loc2_ === undefined) && !this.textSet)
         {
            this.text=_loc2_;
            this.textSet=false;
         }
         dispatchEvent(new FlexEvent(FlexEvent.DATA_CHANGE));
         return;
      }

      private var _displayAsPassword:Boolean = false;

      private var displayAsPasswordChanged:Boolean = false;

      public function get displayAsPassword() : Boolean {
         return this._displayAsPassword;
      }

      public function set displayAsPassword(param1:Boolean) : void {
         if(param1 == this._displayAsPassword)
         {
            return;
         }
         this._displayAsPassword=param1;
         this.displayAsPasswordChanged=true;
         invalidateProperties();
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("displayAsPasswordChanged"));
         return;
      }

      private var _editable:Boolean = true;

      private var editableChanged:Boolean = false;

      public function get editable() : Boolean {
         return this._editable;
      }

      public function set editable(param1:Boolean) : void {
         if(param1 == this._editable)
         {
            return;
         }
         this._editable=param1;
         this.editableChanged=true;
         invalidateProperties();
         dispatchEvent(new Event("editableChanged"));
         return;
      }

      public function get enableIME() : Boolean {
         return this.editable;
      }

      private var _htmlText:String = "";

      private var htmlTextChanged:Boolean = false;

      private var explicitHTMLText:String = null;

      public function get htmlText() : String {
         return this._htmlText;
      }

      public function set htmlText(param1:String) : void {
         this.textSet=true;
         if(!param1)
         {
            param1="";
         }
         this._htmlText=param1;
         this.htmlTextChanged=true;
         this._text=null;
         this.explicitHTMLText=param1;
         invalidateProperties();
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("htmlTextChanged"));
         return;
      }

      private var _imeMode:String = null;

      public function get imeMode() : String {
         return this._imeMode;
      }

      public function set imeMode(param1:String) : void {
         this._imeMode=param1;
         return;
      }

      private function get isHTML() : Boolean {
         return !(this.explicitHTMLText == null);
      }

      public function get length() : int {
         return this.text != null?this.text.length:-1;
      }

      private var _listData:BaseListData;

      public function get listData() : BaseListData {
         return this._listData;
      }

      public function set listData(param1:BaseListData) : void {
         this._listData=param1;
         return;
      }

      private var _maxChars:int = 0;

      private var maxCharsChanged:Boolean = false;

      public function get maxChars() : int {
         return this._maxChars;
      }

      public function set maxChars(param1:int) : void {
         if(param1 == this._maxChars)
         {
            return;
         }
         this._maxChars=param1;
         this.maxCharsChanged=true;
         invalidateProperties();
         dispatchEvent(new Event("maxCharsChanged"));
         return;
      }

      private var _restrict:String = null;

      private var restrictChanged:Boolean = false;

      public function get restrict() : String {
         return this._restrict;
      }

      public function set restrict(param1:String) : void {
         if(param1 == this._restrict)
         {
            return;
         }
         this._restrict=param1;
         this.restrictChanged=true;
         invalidateProperties();
         dispatchEvent(new Event("restrictChanged"));
         return;
      }

      private var _selectable:Boolean = true;

      private var selectableChanged:Boolean = false;

      public function get selectable() : Boolean {
         return this._selectable;
      }

      public function set selectable(param1:Boolean) : void {
         if(param1 == this.selectable)
         {
            return;
         }
         this._selectable=param1;
         this.selectableChanged=true;
         invalidateProperties();
         return;
      }

      private var _selectionBeginIndex:int = 0;

      public function get selectionBeginIndex() : int {
         return this.textField?this.textField.selectionBeginIndex:this._selectionBeginIndex;
      }

      public function set selectionBeginIndex(param1:int) : void {
         this._selectionBeginIndex=param1;
         this.selectionChanged=true;
         invalidateProperties();
         return;
      }

      private var _selectionEndIndex:int = 0;

      public function get selectionEndIndex() : int {
         return this.textField?this.textField.selectionEndIndex:this._selectionEndIndex;
      }

      public function set selectionEndIndex(param1:int) : void {
         this._selectionEndIndex=param1;
         this.selectionChanged=true;
         invalidateProperties();
         return;
      }

      private var styleSheetChanged:Boolean = false;

      private var _styleSheet:StyleSheet;

      public function get styleSheet() : StyleSheet {
         return this._styleSheet;
      }

      public function set styleSheet(param1:StyleSheet) : void {
         this._styleSheet=param1;
         this.styleSheetChanged=true;
         this.htmlTextChanged=true;
         invalidateProperties();
         return;
      }

      private var _text:String = "";

      private var textChanged:Boolean = false;

      public function get text() : String {
         return this._text;
      }

      public function set text(param1:String) : void {
         this.textSet=true;
         if(!param1)
         {
            param1="";
         }
         if(!this.isHTML && param1 == this._text)
         {
            return;
         }
         this._text=param1;
         this.textChanged=true;
         this._htmlText=null;
         this.explicitHTMLText=null;
         invalidateProperties();
         invalidateSize();
         invalidateDisplayList();
         dispatchEvent(new Event("textChanged"));
         dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
         return;
      }

      private var _textHeight:Number;

      public function get textHeight() : Number {
         return this._textHeight;
      }

      private var _textWidth:Number;

      public function get textWidth() : Number {
         return this._textWidth;
      }

      private var _wordWrap:Boolean = true;

      private var wordWrapChanged:Boolean = false;

      public function get wordWrap() : Boolean {
         return this._wordWrap;
      }

      public function set wordWrap(param1:Boolean) : void {
         if(param1 == this._wordWrap)
         {
            return;
         }
         this._wordWrap=param1;
         this.wordWrapChanged=true;
         invalidateProperties();
         invalidateDisplayList();
         dispatchEvent(new Event("wordWrapChanged"));
         return;
      }

      override protected function createChildren() : void {
         super.createChildren();
         this.createTextField(-1);
         return;
      }

      override protected function commitProperties() : void {
         super.commitProperties();
         if((hasFontContextChanged()) && !(this.textField == null))
         {
            this.removeTextField();
            this.createTextField(-1);
            this.accessibilityPropertiesChanged=true;
            this.condenseWhiteChanged=true;
            this.displayAsPasswordChanged=true;
            this.editableChanged=true;
            this.enabledChanged=true;
            this.maxCharsChanged=true;
            this.restrictChanged=true;
            this.selectableChanged=true;
            this.tabIndexChanged=true;
            this.wordWrapChanged=true;
            this.textChanged=true;
            this.selectionChanged=true;
         }
         if(this.accessibilityPropertiesChanged)
         {
            this.textField.accessibilityProperties=this._accessibilityProperties;
            this.accessibilityPropertiesChanged=false;
         }
         if(this.condenseWhiteChanged)
         {
            this.textField.condenseWhite=this._condenseWhite;
            this.condenseWhiteChanged=false;
         }
         if(this.displayAsPasswordChanged)
         {
            this.textField.displayAsPassword=this._displayAsPassword;
            this.displayAsPasswordChanged=false;
         }
         if(this.editableChanged)
         {
            this.textField.type=(this._editable) && (enabled)?TextFieldType.INPUT:TextFieldType.DYNAMIC;
            this.editableChanged=false;
         }
         if(this.enabledChanged)
         {
            this.textField.enabled=enabled;
            this.enabledChanged=false;
         }
         if(this.maxCharsChanged)
         {
            this.textField.maxChars=this._maxChars;
            this.maxCharsChanged=false;
         }
         if(this.restrictChanged)
         {
            this.textField.restrict=this._restrict;
            this.restrictChanged=false;
         }
         if(this.selectableChanged)
         {
            this.textField.selectable=this._selectable;
            this.selectableChanged=false;
         }
         if(this.styleSheetChanged)
         {
            this.textField.styleSheet=this._styleSheet;
            this.styleSheetChanged=false;
         }
         if(this.tabIndexChanged)
         {
            this.textField.tabIndex=this._tabIndex;
            this.tabIndexChanged=false;
         }
         if(this.wordWrapChanged)
         {
            this.textField.wordWrap=this._wordWrap;
            this.wordWrapChanged=false;
         }
         if((this.textChanged) || (this.htmlTextChanged))
         {
            if(this.isHTML)
            {
               this.textField.htmlText=this.explicitHTMLText;
            }
            else
            {
               this.textField.text=this._text;
            }
            this.textFieldChanged(false,true);
            this.textChanged=false;
            this.htmlTextChanged=false;
         }
         if(this.selectionChanged)
         {
            this.textField.setSelection(this._selectionBeginIndex,this._selectionEndIndex);
            this.selectionChanged=false;
         }
         if(!isNaN(this._hScrollPosition))
         {
            this.horizontalScrollPosition=this._hScrollPosition;
         }
         if(!isNaN(this._vScrollPosition))
         {
            this.verticalScrollPosition=this._vScrollPosition;
         }
         return;
      }

      override protected function measure() : void {
         super.measure();
         measuredMinWidth=DEFAULT_MEASURED_MIN_WIDTH;
         measuredWidth=DEFAULT_MEASURED_WIDTH;
         measuredMinHeight=measuredHeight=2 * DEFAULT_MEASURED_MIN_HEIGHT;
         return;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         var _loc3_:EdgeMetrics = viewMetrics;
         _loc3_.left=_loc3_.left + getStyle("paddingLeft");
         _loc3_.top=_loc3_.top + getStyle("paddingTop");
         _loc3_.right=_loc3_.right + getStyle("paddingRight");
         _loc3_.bottom=_loc3_.bottom + getStyle("paddingBottom");
         this.textField.move(_loc3_.left,_loc3_.top);
         var _loc4_:Number = param1 - _loc3_.left - _loc3_.right;
         var _loc5_:Number = param2 - _loc3_.top - _loc3_.bottom;
         if(_loc3_.top + _loc3_.bottom > 0)
         {
            _loc5_++;
         }
         this.textField.setActualSize(Math.max(4,_loc4_),Math.max(4,_loc5_));
         if(!initialized)
         {
            callLater(invalidateDisplayList);
         }
         else
         {
            callLater(this.adjustScrollBars);
         }
         if(isNaN(this._hScrollPosition))
         {
            this._hScrollPosition=0;
         }
         if(isNaN(this._vScrollPosition))
         {
            this._vScrollPosition=0;
         }
         var _loc6_:Number = Math.min(this.textField.maxScrollH,this._hScrollPosition);
         if(_loc6_ != this.textField.scrollH)
         {
            this.horizontalScrollPosition=_loc6_;
         }
         _loc6_=Math.min(this.textField.maxScrollV-1,this._vScrollPosition);
         if(_loc6_ != this.textField.scrollV-1)
         {
            this.verticalScrollPosition=_loc6_;
         }
         return;
      }

      override public function setFocus() : void {
         var _loc1_:int = verticalScrollPosition;
         this.allowScrollEvent=false;
         this.textField.setFocus();
         this.verticalScrollPosition=_loc1_;
         this.allowScrollEvent=true;
         return;
      }

      override protected function isOurFocus(param1:DisplayObject) : Boolean {
         return param1 == this.textField || (super.isOurFocus(param1));
      }

      mx_internal function createTextField(param1:int) : void {
         if(!this.textField)
         {
            this.textField=IUITextField(createInFontContext(UITextField));
            this.textField.autoSize=TextFieldAutoSize.NONE;
            this.textField.enabled=enabled;
            this.textField.ignorePadding=true;
            this.textField.multiline=true;
            this.textField.selectable=true;
            this.textField.styleName=this;
            this.textField.tabEnabled=true;
            this.textField.type=TextFieldType.INPUT;
            this.textField.useRichTextClipboard=true;
            this.textField.wordWrap=true;
            this.textField.addEventListener(Event.CHANGE,this.textField_changeHandler);
            this.textField.addEventListener(Event.SCROLL,this.textField_scrollHandler);
            this.textField.addEventListener(IOErrorEvent.IO_ERROR,this.textField_ioErrorHandler);
            this.textField.addEventListener(TextEvent.TEXT_INPUT,this.textField_textInputHandler);
            this.textField.addEventListener("textFieldStyleChange",this.textField_textFieldStyleChangeHandler);
            this.textField.addEventListener("textFormatChange",this.textField_textFormatChangeHandler);
            this.textField.addEventListener("textInsert",this.textField_textModifiedHandler);
            this.textField.addEventListener("textReplace",this.textField_textModifiedHandler);
            this.textField.addEventListener("textFieldWidthChange",this.textField_textFieldWidthChangeHandler);
            this.textField.addEventListener("nativeDragDrop",this.textField_nativeDragDropHandler);
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
            this.textField.removeEventListener(Event.CHANGE,this.textField_changeHandler);
            this.textField.removeEventListener(Event.SCROLL,this.textField_scrollHandler);
            this.textField.removeEventListener(IOErrorEvent.IO_ERROR,this.textField_ioErrorHandler);
            this.textField.removeEventListener(TextEvent.TEXT_INPUT,this.textField_textInputHandler);
            this.textField.removeEventListener("textFieldStyleChange",this.textField_textFieldStyleChangeHandler);
            this.textField.removeEventListener("textFormatChange",this.textField_textFormatChangeHandler);
            this.textField.removeEventListener("textInsert",this.textField_textModifiedHandler);
            this.textField.removeEventListener("textReplace",this.textField_textModifiedHandler);
            this.textField.removeEventListener("textFieldWidthChange",this.textField_textFieldWidthChangeHandler);
            this.textField.removeEventListener("nativeDragDrop",this.textField_nativeDragDropHandler);
            removeChild(DisplayObject(this.textField));
            this.textField=null;
         }
         return;
      }

      public function getLineMetrics(param1:int) : TextLineMetrics {
         return this.textField?this.textField.getLineMetrics(param1):null;
      }

      public function setSelection(param1:int, param2:int) : void {
         this._selectionBeginIndex=param1;
         this._selectionEndIndex=param2;
         this.selectionChanged=true;
         invalidateProperties();
         return;
      }

      private function textFieldChanged(param1:Boolean, param2:Boolean) : void {
         var _loc3_:* = false;
         var _loc4_:* = false;
         if(!param1)
         {
            _loc3_=!(this._text == this.textField.text);
            this._text=this.textField.text;
         }
         _loc4_=!(this._htmlText == this.textField.htmlText);
         this._htmlText=this.textField.htmlText;
         if(_loc4_)
         {
            dispatchEvent(new Event("htmlTextChanged"));
         }
         this._textWidth=this.textField.textWidth;
         this._textHeight=this.textField.textHeight;
         return;
      }

      private function adjustScrollBars() : void {
         var _loc1_:Number = this.textField.bottomScrollV - this.textField.scrollV + 1;
         var _loc2_:Number = this.textField.numLines;
         setScrollBarProperties(this.textField.width + this.textField.maxScrollH,this.textField.width,this.textField.numLines,_loc1_);
         return;
      }

      mx_internal function getTextField() : IUITextField {
         return this.textField;
      }

      override protected function focusInHandler(param1:FocusEvent) : void {
         var message:String = null;
         var event:FocusEvent = param1;
         if(event.target == this)
         {
            systemManager.stage.focus=TextField(this.textField);
         }
         var fm:IFocusManager = focusManager;
         if((this.editable) && (fm))
         {
            fm.showFocusIndicator=true;
         }
         if(fm)
         {
            fm.defaultButtonEnabled=false;
         }
         super.focusInHandler(event);
         if(!(this._imeMode == null) && (this._editable))
         {
            if(!this.errorCaught && !(IME.conversionMode == IMEConversionMode.UNKNOWN))
            {
               IME.conversionMode=this._imeMode;
            }
            this.errorCaught=false;
         }
         return;
      }

      override protected function focusOutHandler(param1:FocusEvent) : void {
         var _loc2_:IFocusManager = focusManager;
         if(_loc2_)
         {
            _loc2_.defaultButtonEnabled=true;
         }
         super.focusOutHandler(param1);
         dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
         return;
      }

      override protected function mouseWheelHandler(param1:MouseEvent) : void {
         param1.stopPropagation();
         return;
      }

      override protected function scrollHandler(param1:Event) : void {
         if(param1  is  ScrollEvent)
         {
            if(!liveScrolling && ScrollEvent(param1).detail == ScrollEventDetail.THUMB_TRACK)
            {
               return;
            }
            super.scrollHandler(param1);
            this.textField.scrollH=horizontalScrollPosition;
            this.textField.scrollV=verticalScrollPosition + 1;
            this._vScrollPosition=this.textField.scrollV-1;
            this._hScrollPosition=this.textField.scrollH;
         }
         return;
      }

      private function textField_changeHandler(param1:Event) : void {
         this.textFieldChanged(false,false);
         this.adjustScrollBars();
         this.textChanged=false;
         this.htmlTextChanged=false;
         param1.stopImmediatePropagation();
         dispatchEvent(new Event(Event.CHANGE));
         return;
      }

      private function textField_scrollHandler(param1:Event) : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:ScrollEvent = null;
         if((initialized) && (this.allowScrollEvent))
         {
            _loc2_=this.textField.scrollH - horizontalScrollPosition;
            _loc3_=this.textField.scrollV-1 - verticalScrollPosition;
            this.horizontalScrollPosition=this.textField.scrollH;
            this.verticalScrollPosition=this.textField.scrollV-1;
            if(_loc2_)
            {
               _loc4_=new ScrollEvent(ScrollEvent.SCROLL,false,false,null,horizontalScrollPosition,ScrollEventDirection.HORIZONTAL,_loc2_);
               dispatchEvent(_loc4_);
            }
            if(_loc3_)
            {
               _loc4_=new ScrollEvent(ScrollEvent.SCROLL,false,false,null,verticalScrollPosition,ScrollEventDirection.VERTICAL,_loc3_);
               dispatchEvent(_loc4_);
            }
         }
         return;
      }

      private function textField_ioErrorHandler(param1:IOErrorEvent) : void {
         return;
      }

      private function textField_nativeDragDropHandler(param1:Event) : void {
         this.textField_changeHandler(param1);
         return;
      }

      private function textField_textInputHandler(param1:TextEvent) : void {
         param1.stopImmediatePropagation();
         var _loc2_:TextEvent = new TextEvent(TextEvent.TEXT_INPUT,false,true);
         _loc2_.text=param1.text;
         dispatchEvent(_loc2_);
         if(_loc2_.isDefaultPrevented())
         {
            param1.preventDefault();
         }
         return;
      }

      private function textField_textFieldStyleChangeHandler(param1:Event) : void {
         this.textFieldChanged(true,false);
         return;
      }

      private function textField_textFormatChangeHandler(param1:Event) : void {
         this.textFieldChanged(true,false);
         return;
      }

      private function textField_textModifiedHandler(param1:Event) : void {
         this.textFieldChanged(false,true);
         return;
      }

      private function textField_textFieldWidthChangeHandler(param1:Event) : void {
         this.textFieldChanged(true,false);
         return;
      }
   }

}