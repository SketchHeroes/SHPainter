package mx.controls
{
   import mx.core.mx_internal;
   import mx.skins.halo.SwatchSkin;
   import mx.controls.colorPickerClasses.SwatchPanel;
   import flash.events.Event;
   import mx.events.FlexEvent;
   import mx.styles.StyleProxy;
   import mx.events.ColorPickerEvent;
   import flash.geom.Rectangle;
   import mx.managers.PopUpManager;
   import mx.core.UIComponentGlobals;
   import flash.geom.Point;
   import mx.managers.ISystemManager;
   import mx.effects.Tween;
   import mx.core.LayoutDirection;
   import mx.events.FlexMouseEvent;
   import mx.events.SandboxMouseEvent;
   import mx.core.UIComponent;
   import mx.controls.colorPickerClasses.WebSafePalette;
   import flash.events.FocusEvent;
   import mx.managers.IFocusManager;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import flash.events.MouseEvent;
   import mx.events.DropdownEvent;

   use namespace mx_internal;

   public class ColorPicker extends ComboBase
   {
      public function ColorPicker() {
         super();
         if(!this.isModelInited)
         {
            this.loadDefaultPalette();
         }
         super.editable=false;
         addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      mx_internal  static var createAccessibilityImplementation:Function;

      private static const _swatchStyleFilters:Object = {
                                                              "swatchBorderColor":"swatchBorderColor",
                                                              "swatchBorderSize":"swatchBorderSize"
                                                              };

      mx_internal var showingDropdown:Boolean = false;

      mx_internal var isDown:Boolean = false;

      mx_internal var isOpening:Boolean = false;

      private var dropdownGap:Number = 6;

      private var indexFlag:Boolean = false;

      private var initializing:Boolean = true;

      private var isModelInited:Boolean = false;

      private var collectionChanged:Boolean = false;

      private var swatchPreview:SwatchSkin;

      private var dropdownSwatch:SwatchPanel;

      private var triggerEvent:Event;

      override public function set dataProvider(param1:Object) : void {
         super.dataProvider=param1;
         this.isModelInited=true;
         if(this.dropdownSwatch)
         {
            this.dropdownSwatch.dataProvider=param1;
         }
         return;
      }

      private var _editable:Boolean = true;

      override public function get editable() : Boolean {
         return this._editable;
      }

      override public function set editable(param1:Boolean) : void {
         this._editable=param1;
         if(this.dropdownSwatch)
         {
            this.dropdownSwatch.editable=param1;
         }
         dispatchEvent(new Event("editableChanged"));
         return;
      }

      override public function set selectedIndex(param1:int) : void {
         if((!(selectedIndex == -1) || !isNaN(this.selectedColor)) && !(param1 == selectedIndex))
         {
            if(param1 >= 0)
            {
               this.indexFlag=true;
               this.selectedColor=this.getColor(param1);
               super.selectedIndex=param1;
            }
            if(this.dropdownSwatch)
            {
               this.dropdownSwatch.selectedIndex=param1;
            }
         }
         return;
      }

      override public function set selectedItem(param1:Object) : void {
         if(param1 != selectedItem)
         {
            super.selectedItem=param1;
            if(typeof param1 == "object")
            {
               this.selectedColor=Number(param1[this.colorField]);
            }
            else
            {
               if(typeof param1 == "number")
               {
                  this.selectedColor=Number(param1);
               }
            }
            this.indexFlag=true;
            if(this.dropdownSwatch)
            {
               this.dropdownSwatch.selectedItem=param1;
            }
         }
         return;
      }

      private var _colorField:String = "color";

      public function get colorField() : String {
         return this._colorField;
      }

      public function set colorField(param1:String) : void {
         this._colorField=param1;
         if(this.dropdownSwatch)
         {
            this.dropdownSwatch.colorField=param1;
         }
         dispatchEvent(new Event("colorFieldChanged"));
         return;
      }

      mx_internal function get dropdown() : SwatchPanel {
         return this.dropdownSwatch;
      }

      private var _labelField:String = "label";

      public function get labelField() : String {
         return this._labelField;
      }

      public function set labelField(param1:String) : void {
         this._labelField=param1;
         if(this.dropdownSwatch)
         {
            this.dropdownSwatch.labelField=param1;
         }
         dispatchEvent(new Event("labelFieldChanged"));
         return;
      }

      private var _selectedColor:uint = 0;

      public function get selectedColor() : uint {
         return this._selectedColor;
      }

      public function set selectedColor(param1:uint) : void {
         if(!this.indexFlag)
         {
            super.selectedIndex=this.findColorByName(param1);
         }
         else
         {
            this.indexFlag=false;
         }
         if(param1 != this.selectedColor)
         {
            this._selectedColor=param1;
            this.updateColor(param1);
            if(this.dropdownSwatch)
            {
               this.dropdownSwatch.selectedColor=param1;
            }
         }
         dispatchEvent(new FlexEvent(FlexEvent.VALUE_COMMIT));
         return;
      }

      private var _showTextField:Boolean = true;

      public function get showTextField() : Boolean {
         return this._showTextField;
      }

      public function set showTextField(param1:Boolean) : void {
         this._showTextField=param1;
         if(this.dropdownSwatch)
         {
            this.dropdownSwatch.showTextField=param1;
         }
         return;
      }

      protected function get swatchStyleFilters() : Object {
         return _swatchStyleFilters;
      }

      override protected function initializeAccessibility() : void {
         if(ColorPicker.createAccessibilityImplementation != null)
         {
            ColorPicker.createAccessibilityImplementation(this);
         }
         return;
      }

      override protected function createChildren() : void {
         super.createChildren();
         if(!this.swatchPreview)
         {
            this.swatchPreview=new SwatchSkin();
            this.swatchPreview.styleName=new StyleProxy(this,this.swatchStyleFilters);
            this.swatchPreview.color=this.selectedColor;
            this.swatchPreview.name="colorPickerSwatch";
            addChild(this.swatchPreview);
         }
         setChildIndex(this.swatchPreview,getChildIndex(downArrowButton));
         textInput.visible=false;
         if(!enabled)
         {
            super.enabled=enabled;
         }
         this.initializing=false;
         return;
      }

      override protected function commitProperties() : void {
         super.commitProperties();
         if(this.collectionChanged)
         {
            if(this.findColorByName(this.selectedColor) == -1)
            {
               if(dataProvider.length > 0 && selectedIndex > dataProvider.length)
               {
                  this.selectedIndex=0;
               }
               if(this.getColor(selectedIndex) >= 0)
               {
                  this.selectedColor=this.getColor(selectedIndex);
                  this.swatchPreview.color=this.selectedColor;
               }
               else
               {
                  if(this.dropdownSwatch)
                  {
                     this.swatchPreview.color=this.dropdownSwatch.selectedColor;
                  }
               }
            }
            else
            {
               this.selectedIndex=this.findColorByName(this.selectedColor);
            }
            this.collectionChanged=false;
         }
         return;
      }

      override protected function measure() : void {
         measuredMinWidth=measuredWidth=DEFAULT_MEASURED_MIN_HEIGHT;
         measuredMinHeight=measuredHeight=DEFAULT_MEASURED_MIN_HEIGHT;
         return;
      }

      override protected function updateDisplayList(param1:Number, param2:Number) : void {
         super.updateDisplayList(param1,param2);
         this.swatchPreview.color=this.selectedColor;
         this.swatchPreview.setActualSize(param1,param2);
         downArrowButton.move(0,0);
         downArrowButton.setActualSize(param1,param2);
         if(this.dropdownSwatch)
         {
            this.dropdownSwatch.setActualSize(this.dropdownSwatch.getExplicitOrMeasuredWidth(),this.dropdownSwatch.getExplicitOrMeasuredHeight());
         }
         return;
      }

      override public function styleChanged(param1:String) : void {
         var _loc2_:Object = null;
         if(this.dropdownSwatch)
         {
            if(param1 == "swatchPanelStyleName")
            {
               _loc2_=getStyle("swatchPanelStyleName");
               if(_loc2_)
               {
                  this.dropdownSwatch.styleName=_loc2_;
               }
            }
            this.dropdownSwatch.styleChanged(param1);
         }
         super.styleChanged(param1);
         invalidateDisplayList();
         return;
      }

      public function open() : void {
         this.displayDropdown(true);
         return;
      }

      public function close(param1:Event=null) : void {
         this.displayDropdown(false,param1);
         return;
      }

      mx_internal function getDropdown() : SwatchPanel {
         var _loc1_:Object = null;
         if(this.initializing)
         {
            return null;
         }
         if(!this.dropdownSwatch)
         {
            this.dropdownSwatch=new SwatchPanel();
            this.dropdownSwatch.owner=this;
            this.dropdownSwatch.editable=this.editable;
            this.dropdownSwatch.colorField=this.colorField;
            this.dropdownSwatch.labelField=this.labelField;
            this.dropdownSwatch.dataProvider=dataProvider;
            this.dropdownSwatch.showTextField=this.showTextField;
            this.dropdownSwatch.selectedColor=this.selectedColor;
            this.dropdownSwatch.selectedIndex=selectedIndex;
            this.dropdownSwatch.textInputClass=getStyle("textInputClass");
            _loc1_=getStyle("swatchPanelStyleName");
            if(_loc1_)
            {
               this.dropdownSwatch.styleName=_loc1_;
            }
            this.dropdownSwatch.addEventListener(ColorPickerEvent.ITEM_ROLL_OVER,this.dropdownSwatch_itemRollOverHandler);
            this.dropdownSwatch.addEventListener(ColorPickerEvent.ITEM_ROLL_OUT,this.dropdownSwatch_itemRollOutHandler);
            this.dropdownSwatch.cacheAsBitmap=true;
            this.dropdownSwatch.scrollRect=new Rectangle(0,0,0,0);
            PopUpManager.addPopUp(this.dropdownSwatch,this);
            UIComponentGlobals.layoutManager.validateClient(this.dropdownSwatch,true);
            this.dropdownSwatch.setActualSize(this.dropdownSwatch.getExplicitOrMeasuredWidth(),this.dropdownSwatch.getExplicitOrMeasuredHeight());
            this.dropdownSwatch.validateDisplayList();
         }
         this.dropdownSwatch.layoutDirection=layoutDirection;
         this.dropdownSwatch.scaleX=scaleX;
         this.dropdownSwatch.scaleY=scaleY;
         return this.dropdownSwatch;
      }

      mx_internal function displayDropdown(param1:Boolean, param2:Event=null) : void {
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc6_:Function = null;
         var _loc7_:* = NaN;
         var _loc8_:Point = null;
         var _loc9_:ISystemManager = null;
         var _loc10_:Rectangle = null;
         if(param1 == this.showingDropdown)
         {
            return;
         }
         var _loc5_:Tween = null;
         this.triggerEvent=param2;
         if(param1)
         {
            this.getDropdown();
            _loc8_=new Point(layoutDirection == LayoutDirection.RTL?this.dropdownSwatch.getExplicitOrMeasuredWidth():0,0);
            _loc8_=localToGlobal(_loc8_);
            if(this.dropdownSwatch.parent == null)
            {
               PopUpManager.addPopUp(this.dropdownSwatch,this,false);
            }
            else
            {
               PopUpManager.bringToFront(this.dropdownSwatch);
            }
            this.dropdownSwatch.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE,this.dropdownSwatch_mouseDownOutsideHandler);
            this.dropdownSwatch.addEventListener(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE,this.dropdownSwatch_mouseDownOutsideHandler);
            this.dropdownSwatch.addEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE,this.dropdownSwatch_mouseDownOutsideHandler);
            this.dropdownSwatch.addEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE,this.dropdownSwatch_mouseDownOutsideHandler);
            this.dropdownSwatch.isOpening=true;
            this.dropdownSwatch.showTextField=this.showTextField;
            this.dropdownSwatch.selectedColor=this.selectedColor;
            this.dropdownSwatch.owner=this;
            _loc9_=systemManager.topLevelSystemManager;
            _loc10_=_loc9_.getVisibleApplicationRect(null,true);
            if(_loc8_.y + height + this.dropdownGap + this.dropdownSwatch.height > _loc10_.bottom && _loc8_.y > _loc10_.top + this.dropdownGap + this.dropdownSwatch.height)
            {
               _loc8_.y=_loc8_.y - (this.dropdownGap + this.dropdownSwatch.height);
               _loc3_=-this.dropdownSwatch.height / scaleY;
               this.dropdownSwatch.tweenUp=true;
            }
            else
            {
               _loc8_.y=_loc8_.y + (this.dropdownGap + height);
               _loc3_=this.dropdownSwatch.height / scaleY;
               this.dropdownSwatch.tweenUp=false;
            }
            if(_loc8_.x + this.dropdownSwatch.width > _loc10_.right && _loc8_.x > _loc10_.left + this.dropdownSwatch.width)
            {
               _loc8_.x=_loc8_.x - (this.dropdownSwatch.width - width);
            }
            _loc8_.x=Math.max(_loc8_.x,0);
            _loc8_=this.dropdownSwatch.parent.globalToLocal(_loc8_);
            this.dropdownSwatch.move(_loc8_.x,_loc8_.y);
            this.isDown=true;
            this.isOpening=true;
            _loc4_=0;
            _loc7_=getStyle("openDuration");
            _loc6_=getStyle("openEasingFunction") as Function;
            this.showingDropdown=param1;
         }
         else
         {
            _loc3_=0;
            _loc4_=this.dropdownSwatch.tweenUp?-this.dropdownSwatch.height / scaleY:this.dropdownSwatch.height / scaleY;
            this.isDown=false;
            _loc7_=getStyle("closeDuration");
            _loc6_=getStyle("closeEasingFunction") as Function;
            this.showingDropdown=param1;
            this.dropdownSwatch.removeEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE,this.dropdownSwatch_mouseDownOutsideHandler);
            this.dropdownSwatch.removeEventListener(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE,this.dropdownSwatch_mouseDownOutsideHandler);
            this.dropdownSwatch.removeEventListener(SandboxMouseEvent.MOUSE_DOWN_SOMEWHERE,this.dropdownSwatch_mouseDownOutsideHandler);
            this.dropdownSwatch.removeEventListener(SandboxMouseEvent.MOUSE_WHEEL_SOMEWHERE,this.dropdownSwatch_mouseDownOutsideHandler);
            PopUpManager.removePopUp(this.dropdownSwatch);
         }
         if(this.dropdownSwatch)
         {
            this.dropdownSwatch.visible=true;
            this.dropdownSwatch.enabled=false;
         }
         UIComponentGlobals.layoutManager.validateNow();
         UIComponent.suspendBackgroundProcessing();
         _loc5_=new Tween(this,_loc3_,_loc4_,_loc7_);
         if(_loc6_ != null)
         {
            _loc5_.easingFunction=_loc6_;
         }
         return;
      }

      private function loadDefaultPalette() : void {
         var _loc1_:WebSafePalette = null;
         if(!dataProvider || dataProvider.length < 1)
         {
            _loc1_=new WebSafePalette();
            this.dataProvider=_loc1_.getList();
         }
         this.selectedIndex=this.findColorByName(this.selectedColor);
         return;
      }

      private function updateColor(param1:Number) : void {
         if((this.initializing) || (isNaN(param1)))
         {
            return;
         }
         this.swatchPreview.updateSkin(param1);
         return;
      }

      private function findColorByName(param1:Number) : int {
         if(param1 == this.getColor(selectedIndex))
         {
            return selectedIndex;
         }
         var _loc2_:int = dataProvider.length;
         var _loc3_:* = 0;
         while(_loc3_ < dataProvider.length)
         {
            if(param1 == this.getColor(_loc3_))
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }

      private function getColor(param1:int) : Number {
         if(!dataProvider || dataProvider.length < 1 || param1 < 0 || param1 >= dataProvider.length)
         {
            return -1;
         }
         return Number(typeof dataProvider.getItemAt(param1) == "object"?dataProvider.getItemAt(param1)[this.colorField]:dataProvider.getItemAt(param1));
      }

      override protected function focusInHandler(param1:FocusEvent) : void {
         var _loc2_:IFocusManager = focusManager;
         if(_loc2_)
         {
            _loc2_.showFocusIndicator=true;
         }
         if((this.isDown) && !this.isOpening)
         {
            this.close();
         }
         else
         {
            if(this.isOpening)
            {
               this.isOpening=false;
            }
         }
         super.focusInHandler(param1);
         return;
      }

      override protected function keyDownHandler(param1:KeyboardEvent) : void {
         var _loc2_:ColorPickerEvent = null;
         var _loc3_:uint = mapKeycodeForLayoutDirection(param1);
         if((param1.ctrlKey) && _loc3_ == Keyboard.DOWN)
         {
            this.displayDropdown(true,param1);
         }
         else
         {
            if((param1.ctrlKey) && _loc3_ == Keyboard.UP || _loc3_ == Keyboard.ESCAPE)
            {
               if((this.dropdownSwatch) && (this.dropdownSwatch.enabled))
               {
                  this.close(param1);
               }
            }
            else
            {
               if((this.showingDropdown) && _loc3_ == Keyboard.ENTER && (this.dropdownSwatch.enabled))
               {
                  if(!this.dropdownSwatch.isOverGrid && (this.editable))
                  {
                     if(this.selectedColor != this.dropdownSwatch.selectedColor)
                     {
                        this.selectedColor=this.dropdownSwatch.selectedColor;
                        _loc2_=new ColorPickerEvent(ColorPickerEvent.CHANGE);
                        _loc2_.index=selectedIndex;
                        _loc2_.color=this.selectedColor;
                        dispatchEvent(_loc2_);
                        _loc2_=new ColorPickerEvent(ColorPickerEvent.ENTER);
                        _loc2_.color=this.selectedColor;
                        dispatchEvent(_loc2_);
                     }
                  }
                  else
                  {
                     if(selectedIndex != this.dropdownSwatch.focusedIndex)
                     {
                        this.dropdownSwatch.selectedIndex=this.dropdownSwatch.focusedIndex;
                        this.selectedIndex=this.dropdownSwatch.selectedIndex;
                        _loc2_=new ColorPickerEvent(ColorPickerEvent.CHANGE);
                        _loc2_.index=selectedIndex;
                        _loc2_.color=this.selectedColor;
                        dispatchEvent(_loc2_);
                     }
                  }
                  this.close();
                  param1.stopPropagation();
               }
               else
               {
                  if((this.showingDropdown) && (_loc3_ == Keyboard.HOME || _loc3_ == Keyboard.END || _loc3_ == Keyboard.PAGE_UP || _loc3_ == Keyboard.PAGE_DOWN || _loc3_ == Keyboard.LEFT || _loc3_ == Keyboard.RIGHT || _loc3_ == Keyboard.UP || _loc3_ == Keyboard.DOWN))
                  {
                     this.dropdownSwatch.dispatchEvent(param1);
                  }
                  else
                  {
                     if(_loc3_ == Keyboard.LEFT)
                     {
                        if(selectedIndex == -1)
                        {
                           this.selectedIndex=this.findColorByName(this.selectedColor);
                        }
                        if(selectedIndex-1 >= 0)
                        {
                           selectedIndex--;
                           _loc2_=new ColorPickerEvent(ColorPickerEvent.CHANGE);
                           _loc2_.index=selectedIndex;
                           _loc2_.color=this.selectedColor;
                           dispatchEvent(_loc2_);
                        }
                     }
                     else
                     {
                        if(_loc3_ == Keyboard.RIGHT)
                        {
                           if(selectedIndex == -1)
                           {
                              this.selectedIndex=this.findColorByName(this.selectedColor);
                           }
                           if(selectedIndex + 1 < dataProvider.length)
                           {
                              selectedIndex++;
                              _loc2_=new ColorPickerEvent(ColorPickerEvent.CHANGE);
                              _loc2_.index=selectedIndex;
                              _loc2_.color=this.selectedColor;
                              dispatchEvent(_loc2_);
                           }
                        }
                     }
                  }
               }
            }
         }
         return;
      }

      override protected function collectionChangeHandler(param1:Event) : void {
         if(!this.initializing)
         {
            if(dataProvider.length > 0)
            {
               invalidateProperties();
            }
            else
            {
               this.selectedColor=0;
               this.selectedIndex=-1;
            }
            this.collectionChanged=true;
         }
         if(this.dropdownSwatch)
         {
            this.dropdownSwatch.dataProvider=dataProvider;
         }
         return;
      }

      override protected function downArrowButton_buttonDownHandler(param1:FlexEvent) : void {
         this.displayDropdown(!this.showingDropdown,param1);
         return;
      }

      private function dropdownSwatch_itemRollOverHandler(param1:ColorPickerEvent) : void {
         dispatchEvent(param1);
         return;
      }

      private function dropdownSwatch_itemRollOutHandler(param1:ColorPickerEvent) : void {
         dispatchEvent(param1);
         return;
      }

      private function dropdownSwatch_mouseDownOutsideHandler(param1:Event) : void {
         var _loc2_:MouseEvent = null;
         if(param1  is  MouseEvent)
         {
            _loc2_=MouseEvent(param1);
            if(!hitTestPoint(_loc2_.stageX,_loc2_.stageY,true))
            {
               this.close(param1);
            }
         }
         else
         {
            if(param1  is  SandboxMouseEvent)
            {
               this.close(param1);
            }
         }
         return;
      }

      mx_internal function onTweenUpdate(param1:Number) : void {
         this.dropdownSwatch.scrollRect=new Rectangle(0,param1,this.dropdownSwatch.width,this.dropdownSwatch.height);
         return;
      }

      mx_internal function onTweenEnd(param1:Number) : void {
         if(this.showingDropdown)
         {
            this.dropdownSwatch.scrollRect=null;
         }
         else
         {
            this.onTweenUpdate(param1);
            this.dropdownSwatch.visible=false;
            this.isOpening=false;
         }
         UIComponent.resumeBackgroundProcessing();
         if((this.showingDropdown) && (this.showTextField))
         {
            this.dropdownSwatch.callLater(this.dropdownSwatch.setFocus);
         }
         else
         {
            setFocus();
         }
         this.dropdownSwatch.enabled=true;
         dispatchEvent(new DropdownEvent(this.showingDropdown?DropdownEvent.OPEN:DropdownEvent.CLOSE,false,false,this.triggerEvent));
         return;
      }
   }

}