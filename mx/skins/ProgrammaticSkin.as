package mx.skins
{
   import mx.core.FlexShape;
   import mx.core.IFlexDisplayObject;
   import mx.core.IInvalidating;
   import mx.managers.ILayoutManagerClient;
   import mx.styles.ISimpleStyleClient;
   import mx.core.IProgrammaticSkin;
   import mx.core.mx_internal;
   import flash.geom.Matrix;
   import mx.styles.IStyleClient;
   import mx.core.UIComponentGlobals;
   import mx.styles.IStyleManager2;
   import flash.utils.getDefinitionByName;
   import mx.styles.StyleManager;
   import flash.display.Graphics;
   import mx.utils.GraphicsUtil;

   use namespace mx_internal;

   public class ProgrammaticSkin extends FlexShape implements IFlexDisplayObject, IInvalidating, ILayoutManagerClient, ISimpleStyleClient, IProgrammaticSkin
   {
      public function ProgrammaticSkin() {
         super();
         this._width=this.measuredWidth;
         this._height=this.measuredHeight;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private static var tempMatrix:Matrix = new Matrix();

      private static var uiComponentClass:Class;

      private var invalidateDisplayListFlag:Boolean = false;

      private var _height:Number;

      override public function get height() : Number {
         return this._height;
      }

      override public function set height(param1:Number) : void {
         this._height=param1;
         this.invalidateDisplayList();
         return;
      }

      private var _width:Number;

      override public function get width() : Number {
         return this._width;
      }

      override public function set width(param1:Number) : void {
         this._width=param1;
         this.invalidateDisplayList();
         return;
      }

      public function get measuredHeight() : Number {
         return 0;
      }

      public function get measuredWidth() : Number {
         return 0;
      }

      private var _initialized:Boolean = false;

      public function get initialized() : Boolean {
         return this._initialized;
      }

      public function set initialized(param1:Boolean) : void {
         this._initialized=param1;
         return;
      }

      private var _nestLevel:int = 0;

      public function get nestLevel() : int {
         return this._nestLevel;
      }

      public function set nestLevel(param1:int) : void {
         this._nestLevel=param1;
         this.invalidateDisplayList();
         return;
      }

      private var _processedDescriptors:Boolean = false;

      public function get processedDescriptors() : Boolean {
         return this._processedDescriptors;
      }

      public function set processedDescriptors(param1:Boolean) : void {
         this._processedDescriptors=param1;
         return;
      }

      private var _updateCompletePendingFlag:Boolean = true;

      public function get updateCompletePendingFlag() : Boolean {
         return this._updateCompletePendingFlag;
      }

      public function set updateCompletePendingFlag(param1:Boolean) : void {
         this._updateCompletePendingFlag=param1;
         return;
      }

      private var _styleName:IStyleClient;

      public function get styleName() : Object {
         return this._styleName;
      }

      public function set styleName(param1:Object) : void {
         if(this._styleName != param1)
         {
            this._styleName=param1 as IStyleClient;
            this.invalidateDisplayList();
         }
         return;
      }

      public function move(param1:Number, param2:Number) : void {
         this.x=param1;
         this.y=param2;
         return;
      }

      public function setActualSize(param1:Number, param2:Number) : void {
         var _loc3_:* = false;
         if(this._width != param1)
         {
            this._width=param1;
            _loc3_=true;
         }
         if(this._height != param2)
         {
            this._height=param2;
            _loc3_=true;
         }
         return;
      }

      public function validateProperties() : void {
         return;
      }

      public function validateSize(param1:Boolean=false) : void {
         return;
      }

      public function validateDisplayList() : void {
         this.invalidateDisplayListFlag=false;
         this.updateDisplayList(this.width,this.height);
         return;
      }

      public function styleChanged(param1:String) : void {
         this.invalidateDisplayList();
         return;
      }

      public function invalidateDisplayList() : void {
         if(!this.invalidateDisplayListFlag && this.nestLevel > 0)
         {
            this.invalidateDisplayListFlag=true;
            UIComponentGlobals.layoutManager.invalidateDisplayList(this);
         }
         return;
      }

      protected function updateDisplayList(param1:Number, param2:Number) : void {
         return;
      }

      public function invalidateSize() : void {
         return;
      }

      public function invalidateProperties() : void {
         return;
      }

      public function validateNow() : void {
         if(this.invalidateDisplayListFlag)
         {
            this.validateDisplayList();
         }
         return;
      }

      public function getStyle(param1:String) : * {
         return this._styleName?this._styleName.getStyle(param1):null;
      }

      protected function get styleManager() : IStyleManager2 {
         if(uiComponentClass == null)
         {
            uiComponentClass=Class(getDefinitionByName("mx.core.UIComponent"));
         }
         if(this.styleName  is  uiComponentClass)
         {
            return this.styleName.styleManager;
         }
         return StyleManager.getStyleManager(null);
      }

      protected function horizontalGradientMatrix(param1:Number, param2:Number, param3:Number, param4:Number) : Matrix {
         return this.rotatedGradientMatrix(param1,param2,param3,param4,0);
      }

      protected function verticalGradientMatrix(param1:Number, param2:Number, param3:Number, param4:Number) : Matrix {
         return this.rotatedGradientMatrix(param1,param2,param3,param4,90);
      }

      protected function rotatedGradientMatrix(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number) : Matrix {
         tempMatrix.createGradientBox(param3,param4,param5 * Math.PI / 180,param1,param2);
         return tempMatrix;
      }

      protected function drawRoundRect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Object=null, param6:Object=null, param7:Object=null, param8:Matrix=null, param9:String="linear", param10:Array=null, param11:Object=null) : void {
         var _loc13_:* = NaN;
         var _loc14_:Array = null;
         var _loc15_:Object = null;
         var _loc12_:Graphics = graphics;
         if(param3 == 0 || param4 == 0)
         {
            return;
         }
         if(param6 !== null)
         {
            if(param6  is  uint)
            {
               _loc12_.beginFill(uint(param6),Number(param7));
            }
            else
            {
               if(param6  is  Array)
               {
                  _loc14_=param7  is  Array?param7 as Array:[param7,param7];
                  if(!param10)
                  {
                     param10=[0,255];
                  }
                  _loc12_.beginGradientFill(param9,param6 as Array,_loc14_,param10,param8);
               }
            }
         }
         if(!param5)
         {
            _loc12_.drawRect(param1,param2,param3,param4);
         }
         else
         {
            if(param5  is  Number)
            {
               _loc13_=Number(param5) * 2;
               _loc12_.drawRoundRect(param1,param2,param3,param4,_loc13_,_loc13_);
            }
            else
            {
               GraphicsUtil.drawRoundRectComplex(_loc12_,param1,param2,param3,param4,param5.tl,param5.tr,param5.bl,param5.br);
            }
         }
         if(param11)
         {
            _loc15_=param11.r;
            if(_loc15_  is  Number)
            {
               _loc13_=Number(_loc15_) * 2;
               _loc12_.drawRoundRect(param11.x,param11.y,param11.w,param11.h,_loc13_,_loc13_);
            }
            else
            {
               GraphicsUtil.drawRoundRectComplex(_loc12_,param11.x,param11.y,param11.w,param11.h,_loc15_.tl,_loc15_.tr,_loc15_.bl,_loc15_.br);
            }
         }
         if(param6 !== null)
         {
            _loc12_.endFill();
         }
         return;
      }
   }

}