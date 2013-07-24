package mx.controls.colorPickerClasses
{
   import mx.core.UIComponent;
   import mx.managers.IFocusManagerContainer;
   import mx.core.mx_internal;
   import mx.core.ITextInput;
   import mx.skins.halo.SwatchPanelSkin;
   import mx.skins.halo.SwatchSkin;
   import flash.geom.Rectangle;
   import mx.collections.IList;
   import mx.collections.ArrayList;
   import mx.core.IFlexDisplayObject;
   import mx.core.FlexVersion;
   import mx.controls.TextInput;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import mx.styles.StyleManager;
   import flash.events.EventPhase;
   import flash.ui.Keyboard;
   import mx.events.ColorPickerEvent;
   import mx.controls.ColorPicker;

   use namespace mx_internal;

   public class SwatchPanel extends UIComponent implements IFocusManagerContainer
   {
      public function SwatchPanel() {
         super();
         addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveHandler);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal var textInput:ITextInput;

      mx_internal var textInputClass:Class;

      private var border:SwatchPanelSkin;

      private var preview:SwatchSkin;

      private var swatches:SwatchSkin;

      private var highlight:SwatchSkin;

      mx_internal var isOverGrid:Boolean = false;

      mx_internal var isOpening:Boolean = false;

      mx_internal var focusedIndex:int = -1;

      mx_internal var tweenUp:Boolean = false;

      private var initializing:Boolean = true;

      private var indexFlag:Boolean = false;

      private var lastIndex:int = -1;

      private var grid:Rectangle;

      private var rows:int;

      private var horizontalGap:Number;

      private var verticalGap:Number;

      private var columnCount:int;

      private var paddingLeft:Number;

      private var paddingRight:Number;

      private var paddingTop:Number;

      private var paddingBottom:Number;

      private var textFieldWidth:Number;

      private var previewWidth:Number;

      private var previewHeight:Number;

      private var swatchWidth:Number;

      private var swatchHeight:Number;

      private var swatchGridBorderSize:Number;

      private var cellOffset:Number = 1;

      private var itemOffset:Number = 3;

      override public function get height() : Number {
         return getExplicitOrMeasuredHeight();
      }

      override public function set height(param1:Number) : void {
         return;
      }

      override public function get width() : Number {
         return getExplicitOrMeasuredWidth();
      }

      override public function set width(param1:Number) : void {
         return;
      }

      private var _colorField:String = "color";

      public function get colorField() : String {
         return this._colorField;
      }

      public function set colorField(param1:String) : void {
         this._colorField=param1;
         return;
      }

      private var _dataProvider:IList;

      public function get dataProvider() : Object {
         return this._dataProvider;
      }

      public function set dataProvider(param1:Object) : void {
         var _loc2_:IList = null;
         if(param1  is  IList)
         {
            this._dataProvider=IList(param1);
         }
         else
         {
            if(param1  is  Array)
            {
               _loc2_=new ArrayList(param1 as Array);
               param1=_loc2_;
            }
            else
            {
               this._dataProvider=null;
            }
         }
         if(!this.initializing)
         {
            if(this.length == 0 || (isNaN(this.length)))
            {
               this.highlight.visible=false;
               this._selectedIndex=-1;
            }
            this.refresh();
         }
         return;
      }

      private var _editable:Boolean = true;

      public function get editable() : Boolean {
         return this._editable;
      }

      public function set editable(param1:Boolean) : void {
         this._editable=param1;
         if(!this.initializing)
         {
            this.textInput.editable=param1;
         }
         return;
      }

      private var _labelField:String = "label";

      public function get labelField() : String {
         return this._labelField;
      }

      public function set labelField(param1:String) : void {
         this._labelField=param1;
         return;
      }

      public function get length() : int {
         return this._dataProvider?this._dataProvider.length:0;
      }

      private var _selectedColor:uint = 0;

      public function get selectedColor() : uint {
         return this._selectedColor;
      }

      public function set selectedColor(param1:uint) : void {
         var _loc2_:* = 0;
         if(!this.indexFlag)
         {
            _loc2_=this.findColorByName(param1);
            if(_loc2_ != -1)
            {
               this.focusedIndex=this.findColorByName(param1);
               this._selectedIndex=this.focusedIndex;
            }
            else
            {
               this.selectedIndex=-1;
            }
         }
         else
         {
            this.indexFlag=false;
         }
         if(!(param1 == this.selectedColor) || !this.isOverGrid || (this.isOpening))
         {
            this._selectedColor=param1;
            this.updateColor(param1);
            if((this.isOverGrid) || (this.isOpening))
            {
               this.setFocusOnSwatch(this.selectedIndex);
            }
            if(this.isOpening)
            {
               this.isOpening=false;
            }
         }
         return;
      }

      private var _selectedIndex:int = 0;

      public function get selectedIndex() : int {
         return this._selectedIndex;
      }

      public function set selectedIndex(param1:int) : void {
         if(!(param1 == this.selectedIndex) && !this.initializing)
         {
            this.focusedIndex=param1;
            this._selectedIndex=this.focusedIndex;
            if(param1 >= 0)
            {
               this.indexFlag=true;
               this.selectedColor=this.getColor(param1);
            }
         }
         return;
      }

      public function get selectedItem() : Object {
         return this.dataProvider?this.dataProvider.getItemAt(this.selectedIndex):null;
      }

      public function set selectedItem(param1:Object) : void {
         var _loc2_:* = NaN;
         if(param1 != this.selectedItem)
         {
            if(typeof param1 == "object")
            {
               _loc2_=Number(param1[this.colorField]);
            }
            else
            {
               if(typeof param1 == "number")
               {
                  _loc2_=Number(param1);
               }
            }
            this.selectedIndex=this.findColorByName(_loc2_);
         }
         return;
      }

      private var _showTextField:Boolean = true;

      public function get showTextField() : Boolean {
         return this._showTextField;
      }

      public function set showTextField(param1:Boolean) : void {
         this._showTextField=param1;
         if(!this.initializing)
         {
            this.textInput.visible=param1;
         }
         return;
      }

      public function get defaultButton() : IFlexDisplayObject {
         return null;
      }

      public function set defaultButton(param1:IFlexDisplayObject) : void {
         return;
      }

      override protected function createChildren() : void {
         var _loc1_:Class = null;
         super.createChildren();
         if(!this.border)
         {
            this.border=new SwatchPanelSkin();
            this.border.styleName=this;
            this.border.name="swatchPanelBorder";
            addChild(this.border);
         }
         if(!this.preview)
         {
            this.preview=new SwatchSkin();
            this.preview.styleName=this;
            this.preview.color=this.selectedColor;
            this.preview.name="swatchPreview";
            this.preview.setStyle("swatchBorderSize",0);
            addChild(this.preview);
         }
         if(!this.textInput)
         {
            _loc1_=getStyle("textInputClass");
            if(!_loc1_)
            {
               _loc1_=this.textInputClass;
            }
            if(!_loc1_ || FlexVersion.compatibilityVersion < FlexVersion.VERSION_4_0)
            {
               this.textInput=new TextInput();
            }
            else
            {
               this.textInput=new this.textInputClass();
            }
            this.textInput.styleName=getStyle("textFieldStyleName");
            this.textInput.editable=this._editable;
            this.textInput.maxChars=6;
            this.textInput.name="inset";
            this.textInput.text=this.rgbToHex(this.selectedColor);
            this.textInput.restrict="#xa-fA-F0-9";
            this.textInput.addEventListener(Event.CHANGE,this.textInput_changeHandler);
            this.textInput.addEventListener(KeyboardEvent.KEY_DOWN,this.textInput_keyDownHandler);
            addChild(DisplayObject(this.textInput));
         }
         if(!this.swatches)
         {
            this.swatches=new SwatchSkin();
            this.swatches.styleName=this;
            this.swatches.colorField=this.colorField;
            this.swatches.name="swatchGrid";
            this.swatches.addEventListener(MouseEvent.CLICK,this.swatches_clickHandler);
            addChild(this.swatches);
         }
         if(!this.highlight)
         {
            this.highlight=new SwatchSkin();
            this.highlight.styleName=this;
            this.highlight.visible=false;
            this.highlight.name="swatchHighlight";
            addChild(this.highlight);
         }
         this.refresh();
         this.initializing=false;
         return;
      }

      override protected function measure() : void {
         super.measure();
         this.swatches.updateGrid(IList(this.dataProvider));
         measuredWidth=Math.max(this.paddingLeft + this.paddingRight + this.swatches.width,100);
         measuredHeight=Math.max(this.paddingTop + this.previewHeight + this.itemOffset + this.paddingBottom + this.swatches.height,100);
         return;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         this.preview.updateSkin(this.selectedColor);
         this.preview.move(this.paddingLeft,this.paddingTop);
         this.textInput.setActualSize(this.textFieldWidth,this.previewHeight);
         this.textInput.move(this.paddingLeft + this.previewWidth + this.itemOffset,this.paddingTop);
         this.swatches.updateGrid(IList(this.dataProvider));
         this.swatches.move(this.paddingLeft,this.paddingTop + this.previewHeight + this.itemOffset);
         this.highlight.updateSkin(0);
         this.border.setActualSize(param1,param2);
         if(!this.grid)
         {
            this.grid=new Rectangle();
         }
         this.grid.left=this.swatches.x + this.swatchGridBorderSize;
         this.grid.top=this.swatches.y + this.swatchGridBorderSize;
         this.grid.right=this.swatches.x + this.swatchGridBorderSize + (this.swatchWidth-1) * this.columnCount + 1 + this.horizontalGap * (this.columnCount-1);
         this.grid.bottom=this.swatches.y + this.swatchGridBorderSize + (this.swatchHeight-1) * this.rows + 1 + this.verticalGap * (this.rows-1);
         return;
      }

      override public function styleChanged(param1:String) : void {
         super.styleChanged(param1);
         if(!this.initializing)
         {
            this.refresh();
         }
         return;
      }

      override public function drawFocus(param1:Boolean) : void {
         return;
      }

      override public function setFocus() : void {
         if((this.showTextField) && (this.editable))
         {
            this.textInput.setFocus();
            this.textInput.text=this.rgbToHex(this.selectedColor);
         }
         return;
      }

      private function updateStyleCache() : void {
         this.horizontalGap=getStyle("horizontalGap");
         this.verticalGap=getStyle("verticalGap");
         this.columnCount=getStyle("columnCount");
         this.paddingLeft=getStyle("paddingLeft");
         this.paddingRight=getStyle("paddingRight");
         this.paddingTop=getStyle("paddingTop");
         this.paddingBottom=getStyle("paddingBottom");
         this.textFieldWidth=getStyle("textFieldWidth");
         this.previewWidth=getStyle("previewWidth");
         this.previewHeight=getStyle("previewHeight");
         this.swatchWidth=getStyle("swatchWidth");
         this.swatchHeight=getStyle("swatchHeight");
         this.swatchGridBorderSize=getStyle("swatchGridBorderSize");
         if(this.columnCount > this.length)
         {
            this.columnCount=this.length;
         }
         this.rows=Math.ceil(this.length / this.columnCount);
         return;
      }

      private function refresh() : void {
         this.updateStyleCache();
         this.updateDisplayList(unscaledWidth,unscaledHeight);
         invalidateSize();
         return;
      }

      private function updateColor(param1:uint) : void {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if((this.initializing) || (isNaN(param1)))
         {
            return;
         }
         this.preview.updateSkin(param1);
         if(this.isOverGrid)
         {
            _loc2_=null;
            if(this.focusedIndex >= 0 && typeof this.dataProvider.getItemAt(this.focusedIndex) == "object")
            {
               _loc2_=this.dataProvider.getItemAt(this.focusedIndex)[this.labelField];
            }
            if(!(this.textInput  is  TextInput))
            {
               _loc3_=this.textInput.selectionAnchorPosition;
               _loc4_=this.textInput.selectionActivePosition;
            }
            this.textInput.text=!(_loc2_ == null) && !(_loc2_.length == 0)?_loc2_:this.rgbToHex(param1);
            if(!(this.textInput  is  TextInput))
            {
               this.textInput.selectRange(_loc3_,_loc4_);
            }
         }
         return;
      }

      private function rgbToHex(param1:uint) : String {
         var _loc2_:String = param1.toString(16);
         var _loc3_:String = "00000" + _loc2_;
         var _loc4_:int = _loc3_.length;
         _loc3_=_loc3_.substring(_loc4_ - 6,_loc4_);
         return _loc3_.toUpperCase();
      }

      private function findColorByName(param1:Number) : int {
         if(param1 == this.getColor(this.selectedIndex))
         {
            return this.selectedIndex;
         }
         var _loc2_:* = 0;
         while(_loc2_ < this.length)
         {
            if(param1 == this.getColor(_loc2_))
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }

      private function getColor(param1:int) : uint {
         if(!this.dataProvider || this.dataProvider.length < 1 || param1 < 0 || param1 >= this.length)
         {
            return StyleManager.NOT_A_COLOR;
         }
         return uint(typeof this.dataProvider.getItemAt(param1) == "object"?this.dataProvider.getItemAt(param1)[this.colorField]:this.dataProvider.getItemAt(param1));
      }

      private function setFocusOnSwatch(param1:int) : void {
         if(param1 < 0 || param1 > this.length-1)
         {
            this.highlight.visible=false;
            return;
         }
         var _loc2_:Number = Math.floor(param1 / this.columnCount);
         var _loc3_:Number = param1 - _loc2_ * this.columnCount;
         var _loc4_:Number = this.swatchWidth * _loc3_ + this.horizontalGap * _loc3_ - this.cellOffset * _loc3_ + this.paddingLeft + this.swatchGridBorderSize;
         var _loc5_:Number = this.swatchHeight * _loc2_ + this.verticalGap * _loc2_ - this.cellOffset * _loc2_ + this.paddingTop + this.previewHeight + this.itemOffset + this.swatchGridBorderSize;
         this.highlight.move(_loc4_,_loc5_);
         this.highlight.visible=true;
         this.isOverGrid=true;
         this.updateColor(this.getColor(param1));
         return;
      }

      override protected function keyDownHandler(param1:KeyboardEvent) : void {
         if(!(param1.eventPhase == EventPhase.AT_TARGET) || !enabled)
         {
            return;
         }
         if(this.focusedIndex == -1 || (isNaN(this.focusedIndex)))
         {
            this.focusedIndex=0;
         }
         var _loc2_:int = Math.floor(this.focusedIndex / this.columnCount);
         var _loc3_:uint = mapKeycodeForLayoutDirection(param1);
         switch(_loc3_)
         {
            case Keyboard.UP:
               this.focusedIndex=this.focusedIndex - this.columnCount < 0?(this.rows-1) * this.columnCount + this.focusedIndex + 1:this.focusedIndex - this.columnCount;
               this.isOverGrid=true;
               break;
            case Keyboard.DOWN:
               this.focusedIndex=this.focusedIndex + this.columnCount > this.length?this.focusedIndex-1 - (this.rows-1) * this.columnCount:this.focusedIndex + this.columnCount;
               this.isOverGrid=true;
               break;
            case Keyboard.LEFT:
               this.focusedIndex=this.focusedIndex < 1?this.length-1:this.focusedIndex-1;
               this.isOverGrid=true;
               break;
            case Keyboard.RIGHT:
               this.focusedIndex=this.focusedIndex >= this.length-1?0:this.focusedIndex + 1;
               this.isOverGrid=true;
               break;
            case Keyboard.PAGE_UP:
               this.focusedIndex=this.focusedIndex - _loc2_ * this.columnCount;
               this.isOverGrid=true;
               break;
            case Keyboard.PAGE_DOWN:
               this.focusedIndex=this.focusedIndex + (this.rows-1) * this.columnCount - _loc2_ * this.columnCount;
               this.isOverGrid=true;
               break;
            case Keyboard.HOME:
               this.focusedIndex=this.focusedIndex - (this.focusedIndex - _loc2_ * this.columnCount);
               this.isOverGrid=true;
               break;
            case Keyboard.END:
               this.focusedIndex=this.focusedIndex + (_loc2_ * this.columnCount - this.focusedIndex) + (this.columnCount-1);
               this.isOverGrid=true;
               break;
         }
         if(this.focusedIndex < this.length && (this.isOverGrid))
         {
            this.setFocusOnSwatch(this.focusedIndex);
            dispatchEvent(new Event("change"));
         }
         return;
      }

      private function mouseMoveHandler(param1:MouseEvent) : void {
         var _loc2_:ColorPickerEvent = null;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         if((ColorPicker(owner).isDown) && (enabled))
         {
            if(mouseX > this.grid.left && mouseX < this.grid.right && mouseY > this.grid.top && mouseY < this.grid.bottom)
            {
               _loc3_=Math.floor((Math.floor(mouseX) - (this.grid.left + this.verticalGap)) / (this.swatchWidth + this.horizontalGap - this.cellOffset));
               _loc4_=Math.floor((Math.floor(mouseY) - this.grid.top) / (this.swatchHeight + this.verticalGap - this.cellOffset));
               _loc5_=_loc4_ * this.columnCount + _loc3_;
               if(_loc3_ == -1)
               {
                  _loc5_++;
               }
               else
               {
                  if(_loc3_ > this.columnCount-1)
                  {
                     _loc5_--;
                  }
                  else
                  {
                     if(_loc4_ > this.rows-1)
                     {
                        _loc5_=_loc5_ - this.columnCount;
                     }
                     else
                     {
                        if(_loc5_ < 0)
                        {
                           _loc5_=_loc5_ + this.columnCount;
                        }
                     }
                  }
               }
               if((!(this.lastIndex == _loc5_) || this.highlight.visible == false) && _loc5_ < this.length)
               {
                  if(!(this.lastIndex == -1) && !(this.lastIndex == _loc5_))
                  {
                     _loc2_=new ColorPickerEvent(ColorPickerEvent.ITEM_ROLL_OUT);
                     _loc2_.index=this.lastIndex;
                     _loc2_.color=this.getColor(this.lastIndex);
                     dispatchEvent(_loc2_);
                  }
                  this.focusedIndex=_loc5_;
                  this.lastIndex=this.focusedIndex;
                  this.setFocusOnSwatch(this.focusedIndex);
                  _loc2_=new ColorPickerEvent(ColorPickerEvent.ITEM_ROLL_OVER);
                  _loc2_.index=this.focusedIndex;
                  _loc2_.color=this.getColor(this.focusedIndex);
                  dispatchEvent(_loc2_);
               }
            }
            else
            {
               if(this.highlight.visible == true && (this.isOverGrid) && !(this.lastIndex == -1))
               {
                  this.highlight.visible=false;
                  _loc2_=new ColorPickerEvent(ColorPickerEvent.ITEM_ROLL_OUT);
                  _loc2_.index=this.lastIndex;
                  _loc2_.color=this.getColor(this.lastIndex);
                  dispatchEvent(_loc2_);
               }
               this.isOverGrid=false;
            }
         }
         return;
      }

      private function swatches_clickHandler(param1:MouseEvent) : void {
         var _loc2_:ColorPickerEvent = null;
         if(!enabled)
         {
            return;
         }
         if(mouseX > this.grid.left && mouseX < this.grid.right && mouseY > this.grid.top && mouseY < this.grid.bottom)
         {
            this.selectedIndex=this.focusedIndex;
            if(ColorPicker(owner).selectedIndex != this.selectedIndex)
            {
               ColorPicker(owner).selectedIndex=this.selectedIndex;
               _loc2_=new ColorPickerEvent(ColorPickerEvent.CHANGE);
               _loc2_.index=this.selectedIndex;
               _loc2_.color=this.getColor(this.selectedIndex);
               ColorPicker(owner).dispatchEvent(_loc2_);
            }
            ColorPicker(owner).close();
         }
         return;
      }

      private function textInput_keyDownHandler(param1:KeyboardEvent) : void {
         ColorPicker(owner).dispatchEvent(param1);
         return;
      }

      private function textInput_changeHandler(param1:Event) : void {
         var _loc2_:String = ITextInput(param1.target).text;
         if(_loc2_.charAt(0) == "#")
         {
            this.textInput.maxChars=7;
            _loc2_="0x" + _loc2_.substring(1);
         }
         else
         {
            if(_loc2_.substring(0,2) == "0x")
            {
               this.textInput.maxChars=8;
            }
            else
            {
               this.textInput.maxChars=6;
               _loc2_="0x" + _loc2_;
            }
         }
         this.highlight.visible=false;
         this.isOverGrid=false;
         this.selectedColor=Number(_loc2_);
         dispatchEvent(new Event("change"));
         return;
      }
   }

}