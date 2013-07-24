package components
{
   import mx.containers.Canvas;
   import mx.core.UIComponent;
   import mx.controls.HSlider;
   import mx.controls.Image;
   import mx.controls.CheckBox;
   import mx.containers.Tile;
   import mx.controls.Text;
   import mx.core.UIComponentDescriptor;
   import mx.core.IFlexModuleFactory;
   import flash.accessibility.*;
   import flash.debugger.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   import mx.binding.*;
   import mx.styles.*;
   import com.reinatech.shpainter.tools.*;
   import mx.core.mx_internal;
   import com.reinatech.player.Player;
   import asset.EditorTemplate;
   import com.reinatech.shpainter.history.HistoryStack;
   import com.reinatech.player.events.ToolChangedEvent;
   import com.reinatech.player.events.PencilCursorPositionChangedEvent;
   import com.reinatech.player.events.AnimationFinishedEvent;
   import com.reinatech.player.PlayerCanvas;
   import asset.stepChoose;
   import mx.controls.Button;
   import mx.managers.PopUpManager;
   import com.reinatech.player.events.PublishEvent;
   import mx.containers.HBox;
   import mx.controls.Label;
   import com.reinatech.shpainter.utils.ProjectUtils;
   import mx.graphics.codec.JPEGEncoder;
   import mx.core.Application;
   import mx.utils.Base64Encoder;
   import mx.controls.Alert;
   import com.reinatech.shpainter.utils.Printer;
   import mx.events.SliderEvent;
   import mx.events.PropertyChangeEvent;

   use namespace CSSStyleDeclaration;
   use namespace mx_internal;
   use namespace StyleManager;

   public class Editor extends Canvas
   {
      public function Editor() {
         this._documentDescriptor_=new UIComponentDescriptor(
            {
               "type":Canvas,
               "stylesFactory":new function():void
               {
                  this.backgroundAlpha=0.0;
                  return;
                  },
                  "propertiesFactory":new function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor(
                        {
                           "type":Canvas,
                           "propertiesFactory":new function():Object
                           {
                              return {
                              "x":20,
                              "y":20,
                              "width":701,
                              "height":591.5,
                              "childDescriptors":[new UIComponentDescriptor(
                                 {
                                    "type":UIComponent,
                                    "id":"_skin",
                                    "propertiesFactory":new function():Object
                                    {
                                       return {
                                       "x":0,
                                       "y":0
                                    }
                                    ;
                                 }
                           }
                           ),new UIComponentDescriptor(
                           {
                                 "type":Canvas,
                                 "id":"parentCanv",
                                 "propertiesFactory":new function():Object
                                 {
                                    return {
                                    "x":65,
                                    "y":50,
                                    "maxWidth":527,
                                    "minWidth":527,
                                    "maxHeight":385,
                                    "minHeight":385,
                                    "horizontalScrollPolicy":"off",
                                    "verticalScrollPolicy":"off",
                                    "childDescriptors":[new UIComponentDescriptor(
                                       {
                                          "type":Text,
                                          "id":"uploadProgress",
                                          "stylesFactory":new function():void
                                          {
                                             this.fontSize=30;
                                             this.fontFamily="arial";
                                             return;
                                             },
                                             "propertiesFactory":new function():Object
                                             {
                                                return {
                                                "alpha":0.5,
                                                "visible":false,
                                                "horizontalCenter":0,
                                                "verticalCenter":0
                                             }
                                             ;
                                          }
                                       }
                                    ),new UIComponentDescriptor(
                                       {
                                          "type":Canvas,
                                          "id":"animationCanvas",
                                          "propertiesFactory":new function():Object
                                          {
                                             return {
                                             "x":0,
                                             "y":0,
                                             "width":527,
                                             "height":385,
                                             "cacheAsBitmap":true,
                                             "horizontalScrollPolicy":"off",
                                             "verticalScrollPolicy":"off"
                                          }
                                          ;
                                       }
                                 }
                                 ),new UIComponentDescriptor(
                                 {
                                       "type":Canvas,
                                       "id":"cursorCanvas",
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":0,
                                          "y":0,
                                          "width":527,
                                          "height":385,
                                          "cacheAsBitmap":true,
                                          "horizontalScrollPolicy":"off",
                                          "verticalScrollPolicy":"off"
                                       }
                                       ;
                                 }
                           }
                           )]
                        }
                        ;
                  }
               }
               ),new UIComponentDescriptor(
               {
                  "type":Image,
                  "id":"toolUsed",
                  "propertiesFactory":new function():Object
                  {
                        return {
                        "x":22,
                        "y":435
                  }
                  ;
               }
            }
            ),new UIComponentDescriptor(
            {
               "type":CheckBox,
               "id":"chkShowPencil",
               "events":{"change":"__chkShowPencil_change"},
               "propertiesFactory":new function():Object
               {
                  return {
                  "selected":false,
                  "x":-42,
                  "y":-59,
                  "width":15,
                  "height":15,
                  "styleName":"chkShowPencil"
               }
               ;
            }
         }
         ),new UIComponentDescriptor(
         {
            "type":HSlider,
            "id":"sliderSpeed",
            "events":{"change":"__sliderSpeed_change"},
            "propertiesFactory":new function():Object
            {
               return {
               "x":484,
               "y":449,
               "width":60,
               "snapInterval":10,
               "showDataTip":false,
               "value":50,
               "minimum":10,
               "maximum":100,
               "sliderThumbClass":CustomThumbCircClass,
               "styleName":"speedSlider"
            }
            ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":HSlider,
         "id":"stepsSlider",
         "events":{"change":"__stepsSlider_change"},
         "stylesFactory":new function():void
         {
            this.borderColor=16777215;
            return;
            },
            "propertiesFactory":new function():Object
            {
               return {
               "x":60,
               "y":431,
               "width":535,
               "height":12,
               "allowTrackClick":false,
               "minimum":0,
               "showDataTip":false,
               "sliderThumbClass":CustomThumbCircClass,
               "snapInterval":1,
               "styleName":"stepsSlider",
               "thumbCount":0
            }
            ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":HSlider,
         "id":"animationSlider",
         "events":
         {
            "change":"__animationSlider_change",
            "mouseDown":"__animationSlider_mouseDown"
         }
         ,
         "stylesFactory":new function():void
         {
            this.thumbOffset=0;
            return;
            },
            "propertiesFactory":new function():Object
            {
               return {
               "x":60,
               "y":431,
               "height":12,
               "width":530,
               "snapInterval":1,
               "liveDragging":false,
               "minimum":0,
               "allowTrackClick":true,
               "showDataTip":false,
               "sliderThumbClass":AnimationThumbClass,
               "styleName":"animationSlider"
            }
            ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":Tile,
         "id":"tileSteps",
         "propertiesFactory":new function():Object
         {
            return {
            "x":4,
            "y":103,
            "width":105,
            "height":270,
            "direction":"horizontal",
            "verticalScrollPolicy":"off"
         }
         ;
         }
         }
         )]
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":Image,
         "id":"bPrint",
         "events":{"mouseDown":"__bPrint_mouseDown"},
         "propertiesFactory":new function():Object
         {
         return {
         "x":-50,
         "y":-30,
         "source":_embed_mxml_assets_editor_close_option_02_png_650840840,
         "width":17,
         "height":16,
         "buttonMode":true,
         "visible":false
         }
         ;
         }
         }
         )]};
         }
         }
         );
         this._2061379153PenCursor=Editor_PenCursor;
         this._981594673PenTool=Editor_PenTool;
         this._1933731794BrushTool=Editor_BrushTool;
         this._635350482PolygonTool=Editor_PolygonTool;
         this._1105139176AirBrushTool=Editor_AirBrushTool;
         this._1944425593RectangleTool=Editor_RectangleTool;
         this._882609832CircleTool=Editor_CircleTool;
         this._1253300172LineTool=Editor_LineTool;
         this._1519653113CurveTool=Editor_CurveTool;
         this._776332127SmudgeTool=Editor_SmudgeTool;
         this._233360702EraseTool=Editor_EraseTool;
         this._1184301374BucketTool=Editor_BucketTool;
         this.StepThumb=Editor_StepThumb;
         this.Transparent=Editor_Transparent;
         this.StepButtonBack=Editor_StepButtonBack;
         this.StepCloseButtonBack=Editor_StepCloseButtonBack;
         this.helpCreatePopUp=new HelpCreatePopUp();
         this.cursorSprite=new MovieClip();
         this.publishAlert=new Publish();
         this._2062599Back=Editor_Back;
         this.uploadStatusPopUp=new HBox();
         this._embed_css____assets_editor_speed_button_PNG_2129448534_1423463322=_class_embed_css____assets_editor_speed_button_PNG_2129448534_1423463322;
         this._embed_css____assets_editor_pencil_png__1148268597_562479163=_class_embed_css____assets_editor_pencil_png__1148268597_562479163;
         this._embed_mxml_assets_editor_close_option_02_png_650840840=Editor__embed_mxml_assets_editor_close_option_02_png_650840840;
         this._embed_css____assets_editor_time__button_PNG_1396869629_792060029=_class_embed_css____assets_editor_time__button_PNG_1396869629_792060029;
         this._embed_css____assets_editor_pencil_off_png_1414597755_21874037=_class_embed_css____assets_editor_pencil_off_png_1414597755_21874037;
         this._embed_css____assets_editor_speed_line_PNG__227421096_804101400=_class_embed_css____assets_editor_speed_line_PNG__227421096_804101400;
         this._embed_css____assets_editor2_speed_bg_png_120524527_958606867=_class_embed_css____assets_editor2_speed_bg_png_120524527_958606867;
         super();
         mx_internal::_document=this;
         return;
      }

      public static const OPEN_DRAWING:String = "openDrawing";

      private var _91266652_skin:UIComponent;

      private var _1564527100animationCanvas:Canvas;

      private var _2032586117animationSlider:HSlider;

      private var _1411928213bPrint:Image;

      private var _939042736chkShowPencil:CheckBox;

      private var _2058558542cursorCanvas:Canvas;

      private var _245198224parentCanv:Canvas;

      private var _69010458sliderSpeed:HSlider;

      private var _591855896stepsSlider:HSlider;

      private var _861926119tileSteps:Tile;

      private var _983548555toolUsed:Image;

      private var _1534483634uploadProgress:Text;

      private var _documentDescriptor_:UIComponentDescriptor;

      private var __moduleFactoryInitialized:Boolean = false;

      override public function set moduleFactory(param1:IFlexModuleFactory) : void {
         var factory:IFlexModuleFactory = param1;
         super.moduleFactory=factory;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized=true;
         if(!this.styleDeclaration)
         {
            this.styleDeclaration=new CSSStyleDeclaration(null,styleManager);
         }
         this.styleDeclaration.defaultFactory=new function():void
         {
            this.backgroundAlpha=0.0;
            return;
         };
         mx_internal::_Editor_StylesInit();
         return;
      }

      override public function initialize() : void {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
         return;
      }

      private var _2061379153PenCursor:Class;

      private var _981594673PenTool:Class;

      private var _1933731794BrushTool:Class;

      private var _635350482PolygonTool:Class;

      private var _1105139176AirBrushTool:Class;

      private var _1944425593RectangleTool:Class;

      private var _882609832CircleTool:Class;

      private var _1253300172LineTool:Class;

      private var _1519653113CurveTool:Class;

      private var _776332127SmudgeTool:Class;

      private var _233360702EraseTool:Class;

      private var _1184301374BucketTool:Class;

      private var StepThumb:Class;

      private var Transparent:Class;

      private var StepButtonBack:Class;

      private var StepCloseButtonBack:Class;

      private var _player:Player;

      private var _user_id:int = 0;

      private var _save_url:String = "";

      private var _isPause:Boolean = false;

      private var currInitTool:int = 0;

      private var totalToolsToInit:int = 0;

      private var isInitBusy:Boolean = false;

      private var helpCreatePopUp:HelpCreatePopUp;

      private var _template:EditorTemplate;

      public function init(param1:int, param2:String) : void {
         this._user_id=param1;
         this._save_url=param2;
         this._template=new EditorTemplate();
         this._skin.addChild(this._template);
         this.initSkin();
         this.currInitTool=0;
         this._clearAnimationCanvas();
         var _loc3_:HistoryStack = HistoryStack.getInstance();
         var _loc4_:Array = _loc3_.getToolsToAnimate();
         this.animationSlider.maximum=_loc4_.length-1;
         this.animationSlider.value=0;
         this.animationSlider.setStyle("trackSkin",this.Transparent);
         this._player=new Player();
         this._player.addEventListener(ToolChangedEvent.ActiveToolChanged,this.activeToolChanged);
         this._player.addEventListener(PencilCursorPositionChangedEvent.CHANGE,this.changeCursorPosition);
         this._player.addEventListener(AnimationFinishedEvent.CHANGE,this.onAnimationFinished);
         this._player.setPlayerCanvas(new PlayerCanvas(this.animationCanvas));
         this._player.setDrawingTools(_loc4_);
         this.stepsSlider.maximum=_loc4_.length-1;
         this.stepsSlider.setStyle("thumbSkin",null);
         var _loc5_:BitmapData = new BitmapData(108,160,true,0);
         var _loc6_:Bitmap = new Bitmap(_loc5_,"auto",true);
         _loc5_.draw(new this.PenCursor());
         this.cursorSprite.addChild(_loc6_);
         this.cursorCanvas.rawChildren.addChild(this.cursorSprite);
         this.cursorCanvas.visible=false;
         this._clearStepsHistory();
         this.uploadProgress.text="0%";
         this.uploadProgress.visible=true;
         this.animationCanvas.visible=false;
         this.totalToolsToInit=_loc4_.length;
         stage.addEventListener(Event.ENTER_FRAME,this.initDrawing);
         return;
      }

      private function initSkin() : void {
         this._template.addEventListener(MouseEvent.CLICK,this.onSkinClick,false,0,true);
         this._cPlay=new CheckButton(this._template.checkPlay,"",false);
         this._cPlay.addEventListener(Event.CHANGE,this.onPlayChange,false,0,true);
         this._template.buttonHelp.enabled=false;
         this._template.buttonFullScreen.visible=false;
         return;
      }

      private function onPlayChange(param1:Event) : void {
         if(this._cPlay.state)
         {
            this.onPlayClick();
         }
         else
         {
            this.onPlayStop();
         }
         return;
      }

      private function onSkinClick(param1:MouseEvent) : void {
         switch(param1.target.name)
         {
            case "buttonShare":
               this.showPublishAlert();
               break;
            case "buttonPause":
               this.onPlayClick();
               break;
            case "buttonFullScreen":
               break;
            case "buttonHelp":
               break;
            case "buttonNext":
               this.onNextStep();
               break;
            case "buttonPrev":
               this.onPreviousStep();
               break;
            case "buttonUp":
               this.tileSteps.verticalScrollPosition=this.tileSteps.verticalScrollPosition - 34.5;
               break;
            case "buttonCreate":
               this.onCreateStep();
               break;
            case "buttonDown":
               this.tileSteps.verticalScrollPosition=this.tileSteps.verticalScrollPosition + 34.5;
               break;
            case "bBack":
               this.openDrawing();
               break;
         }
         return;
      }

      private function initDrawing(param1:Event) : void {
         var _loc2_:DrawingTool = null;
         if(this.isInitBusy)
         {
            return;
         }
         this.isInitBusy=true;
         var _loc3_:* = 0;
         while(true)
         {
            _loc2_=this._player.getDrawingTool(this.currInitTool);
            if(_loc2_ != null)
            {
               this._player.getPlayerCanvas().setActiveBitmapData(_loc2_.getLayerIndex());
               _loc2_.draw(this._player.getPlayerCanvas().getActiveBitmapData(),true,false);
               this.currInitTool++;
               this.uploadProgress.text=int(this.currInitTool * 100 / this.totalToolsToInit) + "%";
               _loc3_++;
               continue;
            }
            break;
         }
         stage.removeEventListener(Event.ENTER_FRAME,this.initDrawing);
         this.uploadProgress.visible=false;
         this.animationCanvas.visible=true;
         this.isInitBusy=false;
         this.animationSlider.value=this.animationSlider.maximum;
         this.isInitBusy=false;
         return;
      }

      private function activeToolChanged(param1:ToolChangedEvent) : void {
         this.animationSlider.value=param1.toolIndex;
         this._setToolUsed(param1.toolClassName);
         return;
      }

      private var cursorSprite:MovieClip;

      private function onAnimationFinished(param1:AnimationFinishedEvent) : void {
         this.cursorCanvas.visible=false;
         return;
      }

      private function changeCursorPosition(param1:PencilCursorPositionChangedEvent) : void {
         if(!this.chkShowPencil.selected)
         {
            return;
         }
         this.cursorCanvas.visible=true;
         var _loc2_:Point = param1.position;
         this.cursorSprite.x=_loc2_.x;
         this.cursorSprite.y=_loc2_.y;
         return;
      }

      private function changeCursorVisibility() : void {
         if(!this.chkShowPencil.selected)
         {
            this.cursorCanvas.visible=false;
         }
         else
         {
            this.cursorCanvas.visible=true;
         }
         return;
      }

      private function removePenCursor() : void {
         return;
      }

      private function _clearAnimationCanvas() : void {
         while(this.animationCanvas.rawChildren.numChildren > 0)
         {
            this.animationCanvas.rawChildren.removeChildAt(0);
         }
         return;
      }

      private function _clearStepsHistory() : void {
         var _loc1_:Array = new Array();
         _loc1_[0]=0;
         this.stepsSlider.values=_loc1_;
         this.stepsSlider.thumbCount=0;
         this.stepsSlider.setStyle("thumbSkin",null);
         while(this.tileSteps.numChildren > 0)
         {
            this.tileSteps.removeChildAt(0);
         }
         return;
      }

      private function onPlayClick() : void {
         this._player.play();
         return;
      }

      private function onPlayStop() : void {
         this._player.stop();
         return;
      }

      private function onFrameChanged() : void {
         this._player.drawTool(this.animationSlider.value);
         if(this.animationCanvas.rawChildren.contains(this.cursorSprite))
         {
            this.animationCanvas.rawChildren.removeChild(this.cursorSprite);
         }
         if(this._isPause)
         {
            this._isPause=false;
            if(this._player.hasNextFrame())
            {
               this._player.play();
            }
         }
         return;
      }

      private function onNextStep() : void {
         this._player.drawNextStep();
         if(this.animationCanvas.rawChildren.contains(this.cursorSprite))
         {
            this.animationCanvas.rawChildren.removeChild(this.cursorSprite);
         }
         return;
      }

      private function onPreviousStep() : void {
         this._player.drawPreviousStep();
         if(this.animationCanvas.rawChildren.contains(this.cursorSprite))
         {
            this.animationCanvas.rawChildren.removeChild(this.cursorSprite);
         }
         return;
      }

      private function updateSteps() : void {
         var _loc1_:Array = this.stepsSlider.values;
         this._player.setSteps(_loc1_);
         return;
      }

      private function onCreateStep() : void {
         this.stopAnimation();
         this._cPlay.state=false;
         if(this._player.isStepExist(this.animationSlider.value))
         {
            return;
         }
         this.stepsSlider.thumbCount=this.stepsSlider.thumbCount + 1;
         var _loc1_:int = this.animationSlider.value;
         this.stepsSlider.setThumbValueAt(this.stepsSlider.thumbCount-1,_loc1_);
         var _loc2_:Array = this.stepsSlider.values;
         this._player.setSteps(_loc2_);
         var _loc3_:int = this._player.getStepsCount();
         this.stepsSlider.setStyle("thumbSkin",this.StepThumb);
         var _loc4_:Canvas = new Canvas();
         var _loc5_:UIComponent = new UIComponent();
         _loc5_.height=28.5;
         _loc5_.width=100;
         var _loc6_:stepChoose = new stepChoose();
         _loc6_.button.addEventListener(MouseEvent.CLICK,this.onStepButtonClicked2);
         _loc6_.buttonChoose.addEventListener(MouseEvent.CLICK,this.onStepCloseButtonClicked2);
         _loc6_.text.text=_loc3_.toString();
         _loc5_.addChild(_loc6_);
         _loc4_.addChild(_loc5_);
         this.tileSteps.addChild(_loc4_);
         if(this.animationCanvas.rawChildren.contains(this.cursorSprite))
         {
            this.animationCanvas.rawChildren.removeChild(this.cursorSprite);
         }
         return;
      }

      private function onStepButtonClicked2(param1:MouseEvent) : void {
         var _loc3_:* = 0;
         var _loc2_:stepChoose = param1.target.parent as stepChoose;
         if(_loc2_)
         {
            _loc3_=parseInt(_loc2_.text.text);
            this._player.playStep(_loc3_);
         }
         return;
      }

      private function onStepButtonClicked(param1:MouseEvent) : void {
         var _loc3_:* = 0;
         var _loc2_:Button = param1.currentTarget as Button;
         if(_loc2_)
         {
            _loc3_=parseInt(_loc2_.id);
            this._player.playStep(_loc3_);
         }
         return;
      }

      private function onStepCloseButtonClicked2(param1:MouseEvent) : void {
         var _loc3_:* = 0;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc2_:stepChoose = param1.target.parent as stepChoose;
         if(_loc2_)
         {
            _loc3_=parseInt(_loc2_.text.text);
            this.tileSteps.removeChildAt(this.tileSteps.numChildren-1);
            this.stepsSlider.thumbCount--;
            _loc4_=this.stepsSlider.values;
            _loc4_.splice(_loc3_,1);
            this.stepsSlider.values=_loc4_;
            this._player.setSteps(_loc4_);
            if(this.stepsSlider.thumbCount == 1)
            {
               _loc5_=new Array();
               _loc5_[0]=0;
               this.stepsSlider.values=_loc5_;
               this._player.setSteps(_loc5_);
               this.stepsSlider.setStyle("thumbSkin",null);
            }
         }
         return;
      }

      private function onStepCloseButtonClicked(param1:MouseEvent) : void {
         var _loc3_:* = 0;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc2_:Button = param1.currentTarget as Button;
         if(_loc2_)
         {
            _loc3_=parseInt(_loc2_.id);
            this.tileSteps.removeChildAt(this.tileSteps.numChildren-1);
            this.stepsSlider.thumbCount--;
            _loc4_=this.stepsSlider.values;
            _loc4_.splice(_loc3_,1);
            this.stepsSlider.values=_loc4_;
            this._player.setSteps(_loc4_);
            if(this.stepsSlider.thumbCount == 1)
            {
               _loc5_=new Array();
               _loc5_[0]=0;
               this.stepsSlider.values=_loc5_;
               this._player.setSteps(_loc5_);
               this.stepsSlider.setStyle("thumbSkin",null);
            }
         }
         return;
      }

      private function speedChanged() : void {
         this.stopAnimation();
         this._player.setSpeed(1000 / this.sliderSpeed.value);
         this._player.play();
         return;
      }

      private function _setToolUsed(param1:String) : void {
         switch(param1)
         {
            case "PenTool":
               this.toolUsed.source=this.PenTool;
               break;
            case "BrushTool":
               this.toolUsed.source=this.BrushTool;
               break;
            case "PolygonTool":
               this.toolUsed.source=this.PolygonTool;
               break;
            case "AirBrushTool":
               this.toolUsed.source=this.AirBrushTool;
               break;
            case "RectangleTool":
               this.toolUsed.source=this.RectangleTool;
               break;
            case "CircleTool":
               this.toolUsed.source=this.CircleTool;
               break;
            case "LineTool":
               this.toolUsed.source=this.LineTool;
               break;
            case "CurveTool":
               this.toolUsed.source=this.CurveTool;
               break;
            case "SmudgeTool":
               this.toolUsed.source=this.SmudgeTool;
               break;
            case "EraseTool":
               this.toolUsed.source=this.EraseTool;
               break;
            case "BucketTool":
               this.toolUsed.source=this.BucketTool;
               break;
         }
         return;
      }

      private function deleteStep() : void {
         var _loc3_:Array = null;
         if(this.tileSteps.numChildren == 0)
         {
            return;
         }
         var _loc1_:int = this._player.getStepByValue(this.animationSlider.value);
         if(_loc1_ == -1)
         {
            return;
         }
         this.tileSteps.removeChildAt(this.tileSteps.numChildren-1);
         this.stepsSlider.thumbCount--;
         var _loc2_:Array = this.stepsSlider.values;
         _loc2_.splice(_loc1_,1);
         this.stepsSlider.values=_loc2_;
         this._player.setSteps(_loc2_);
         if(this.stepsSlider.thumbCount == 1)
         {
            _loc3_=new Array();
            _loc3_[0]=0;
            this.stepsSlider.values=_loc3_;
            this._player.setSteps(_loc3_);
            this.stepsSlider.setStyle("thumbSkin",null);
         }
         return;
      }

      private function openDrawing() : void {
         this.stopAnimation();
         dispatchEvent(new Event(OPEN_DRAWING));
         return;
      }

      private var publishAlert:Publish;

      private function showPublishAlert() : void {
         this.stopAnimation();
         PopUpManager.addPopUp(this.publishAlert,this,true);
         PopUpManager.centerPopUp(this.publishAlert);
         this.publishAlert.addEventListener(Event.CLOSE,this.closePublishAlert);
         this.publishAlert.addEventListener(PublishEvent.PUBLISH,this.publishProject);
         return;
      }

      private var _2062599Back:Class;

      private var uploadStatusPopUp:HBox;

      private var _cPlay:CheckButton;

      private function publishProject(param1:PublishEvent) : void {
         var _loc18_:DrawingTool = null;
         this.publishAlert.removeEventListener(Event.CLOSE,this.closePublishAlert);
         PopUpManager.removePopUp(this.publishAlert);
         if(!this.uploadStatusPopUp)
         {
            this.uploadStatusPopUp=new HBox();
            this.uploadStatusPopUp.width=350;
            this.uploadStatusPopUp.height=290;
            this.uploadStatusPopUp.setStyle("verticalAlign","middle");
            this.uploadStatusPopUp.setStyle("horizontalAlign","center");
            this.uploadStatusPopUp.setStyle("backgroundImage",this.Back);
         }
         var _loc2_:Array = this._player.getSteps();
         var _loc3_:* = "";
         _loc3_=_loc3_ + (_loc2_.toString() + ";");
         var _loc4_:Array = HistoryStack.getInstance().getToolsToAnimate();
         var _loc5_:int = _loc4_.length;
         var _loc6_:* = 0;
         while(_loc6_ < _loc5_)
         {
            _loc18_=_loc4_[_loc6_] as DrawingTool;
            _loc3_=_loc3_ + (_loc18_.saveToolData() + ";");
            _loc6_++;
         }
         this.uploadStatusPopUp.removeAllChildren();
         var _loc7_:Label = new Label();
         _loc7_.text="Uploading...";
         _loc7_.setStyle("fonSize","20");
         _loc7_.setStyle("fontWeight","bold");
         this.uploadStatusPopUp.addChild(_loc7_);
         PopUpManager.addPopUp(this.uploadStatusPopUp,this,false);
         PopUpManager.centerPopUp(this.uploadStatusPopUp);
         var _loc8_:String = this._save_url;
         var _loc9_:URLRequest = new URLRequest(_loc8_);
         var _loc10_:URLVariables = new URLVariables();
         _loc10_.user_id=this._user_id;
         _loc10_.name=param1.title;
         _loc10_.description=param1.description;
         _loc10_.category=param1.category;
         _loc10_.paintdata=ProjectUtils.serializeToString(_loc3_);
         var _loc11_:JPEGEncoder = new JPEGEncoder(100);
         var _loc12_:Matrix = new Matrix();
         var _loc13_:BitmapData = new BitmapData(503,385);
         _loc13_.draw(Application.application.compDrawing.thumb,_loc12_);
         var _loc14_:ByteArray = _loc11_.encode(_loc13_);
         var _loc15_:Base64Encoder = new Base64Encoder();
         _loc15_.encodeBytes(_loc14_);
         var _loc16_:String = _loc15_.toString();
         _loc10_.thumbnail=_loc16_;
         _loc9_.data=_loc10_;
         _loc9_.method=URLRequestMethod.POST;
         var _loc17_:URLLoader = new URLLoader();
         _loc17_.dataFormat=URLLoaderDataFormat.VARIABLES;
         _loc17_.addEventListener(Event.COMPLETE,this.dataOnLoad);
         _loc17_.addEventListener(IOErrorEvent.IO_ERROR,this.dataOnLoadError);
         _loc17_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.dataOnLoadError);
         _loc17_.load(_loc9_);
         return;
      }

      private function dataOnLoad(param1:Event) : void {
         PopUpManager.removePopUp(this.uploadStatusPopUp);
         Alert.show("Project successfully uploaded.","Status",Alert.OK);
         return;
      }

      private function dataOnLoadError(param1:Event) : void {
         PopUpManager.removePopUp(this.uploadStatusPopUp);
         Alert.show("Project is not uploaded. Please try to upload later.","Status",Alert.OK);
         return;
      }

      private function closePublishAlert(param1:Event) : void {
         this.publishAlert.removeEventListener(Event.CLOSE,this.closePublishAlert);
         PopUpManager.removePopUp(this.publishAlert);
         return;
      }

      private function showHelpCreatePopUp() : void {
         this.stopAnimation();
         PopUpManager.addPopUp(this.helpCreatePopUp,this,false);
         PopUpManager.centerPopUp(this.helpCreatePopUp);
         this.helpCreatePopUp.addEventListener(Event.CLOSE,this.closeHelpCreatePopUp);
         return;
      }

      private function closeHelpCreatePopUp(param1:Event) : void {
         this.helpCreatePopUp.removeEventListener(Event.CLOSE,this.closeHelpCreatePopUp);
         PopUpManager.removePopUp(this.helpCreatePopUp);
         return;
      }

      private function printPaint() : void {
         this.stopAnimation();
         Printer.print(this.animationCanvas);
         return;
      }

      private function stopAnimation() : void {
         if(this._player.isPlaying())
         {
            this._player.stop();
            this._cPlay.state=false;
            this._isPause=true;
         }
         return;
      }

      public function __chkShowPencil_change(param1:Event) : void {
         this.changeCursorVisibility();
         return;
      }

      public function __sliderSpeed_change(param1:SliderEvent) : void {
         this.speedChanged();
         return;
      }

      public function __stepsSlider_change(param1:SliderEvent) : void {
         this.updateSteps();
         return;
      }

      public function __animationSlider_change(param1:SliderEvent) : void {
         this.onFrameChanged();
         return;
      }

      public function __animationSlider_mouseDown(param1:MouseEvent) : void {
         this.stopAnimation();
         return;
      }

      public function __bPrint_mouseDown(param1:MouseEvent) : void {
         this.printPaint();
         return;
      }

      mx_internal var _Editor_StylesInit_done:Boolean = false;

      mx_internal function _Editor_StylesInit() : void {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_Editor_StylesInit_done)
         {
            return;
         }
         mx_internal::_Editor_StylesInit_done=true;
         style=styleManager.getStyleDeclaration(".stepsSlider");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".stepsSlider",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.dataTipOffset=0;
               this.trackSkin=_embed_css____assets_editor2_speed_bg_png_120524527_958606867;
               this.dataTipPlacement=right;
               this.thumbSkin=_embed_css____assets_editor_time__button_PNG_1396869629_792060029;
               return;
            };
         }
         style=styleManager.getStyleDeclaration(".animationSlider");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".animationSlider",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.color=1707402;
               this.backgroundColor=40447;
               this.thumbSkin=_embed_css____assets_editor_time__button_PNG_1396869629_792060029;
               return;
            };
         }
         style=styleManager.getStyleDeclaration(".speedSlider");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".speedSlider",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.dataTipOffset=0;
               this.trackSkin=_embed_css____assets_editor_speed_line_PNG__227421096_804101400;
               this.dataTipPlacement=right;
               this.thumbSkin=_embed_css____assets_editor_speed_button_PNG_2129448534_1423463322;
               return;
            };
         }
         style=styleManager.getStyleDeclaration(".chkShowPencil");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".chkShowPencil",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.selectedOverIcon=_embed_css____assets_editor_pencil_png__1148268597_562479163;
               this.selectedUpIcon=_embed_css____assets_editor_pencil_png__1148268597_562479163;
               this.upIcon=_embed_css____assets_editor_pencil_off_png_1414597755_21874037;
               this.selectedDownIcon=_embed_css____assets_editor_pencil_png__1148268597_562479163;
               this.overIcon=_embed_css____assets_editor_pencil_off_png_1414597755_21874037;
               this.downIcon=_embed_css____assets_editor_pencil_off_png_1414597755_21874037;
               return;
            };
         }
         return;
      }

      private var _embed_css____assets_editor_speed_button_PNG_2129448534_1423463322:Class;

      private var _embed_css____assets_editor_pencil_png__1148268597_562479163:Class;

      private var _embed_mxml_assets_editor_close_option_02_png_650840840:Class;

      private var _embed_css____assets_editor_time__button_PNG_1396869629_792060029:Class;

      private var _embed_css____assets_editor_pencil_off_png_1414597755_21874037:Class;

      private var _embed_css____assets_editor_speed_line_PNG__227421096_804101400:Class;

      private var _embed_css____assets_editor2_speed_bg_png_120524527_958606867:Class;

      public function get _skin() : UIComponent {
         return this._91266652_skin;
      }

      public function set _skin(param1:UIComponent) : void {
         var _loc2_:Object = this._91266652_skin;
         if(_loc2_ !== param1)
         {
            this._91266652_skin=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"_skin",_loc2_,param1));
            }
         }
         return;
      }

      public function get animationCanvas() : Canvas {
         return this._1564527100animationCanvas;
      }

      public function set animationCanvas(param1:Canvas) : void {
         var _loc2_:Object = this._1564527100animationCanvas;
         if(_loc2_ !== param1)
         {
            this._1564527100animationCanvas=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"animationCanvas",_loc2_,param1));
            }
         }
         return;
      }

      public function get animationSlider() : HSlider {
         return this._2032586117animationSlider;
      }

      public function set animationSlider(param1:HSlider) : void {
         var _loc2_:Object = this._2032586117animationSlider;
         if(_loc2_ !== param1)
         {
            this._2032586117animationSlider=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"animationSlider",_loc2_,param1));
            }
         }
         return;
      }

      public function get bPrint() : Image {
         return this._1411928213bPrint;
      }

      public function set bPrint(param1:Image) : void {
         var _loc2_:Object = this._1411928213bPrint;
         if(_loc2_ !== param1)
         {
            this._1411928213bPrint=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bPrint",_loc2_,param1));
            }
         }
         return;
      }

      public function get chkShowPencil() : CheckBox {
         return this._939042736chkShowPencil;
      }

      public function set chkShowPencil(param1:CheckBox) : void {
         var _loc2_:Object = this._939042736chkShowPencil;
         if(_loc2_ !== param1)
         {
            this._939042736chkShowPencil=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chkShowPencil",_loc2_,param1));
            }
         }
         return;
      }

      public function get cursorCanvas() : Canvas {
         return this._2058558542cursorCanvas;
      }

      public function set cursorCanvas(param1:Canvas) : void {
         var _loc2_:Object = this._2058558542cursorCanvas;
         if(_loc2_ !== param1)
         {
            this._2058558542cursorCanvas=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cursorCanvas",_loc2_,param1));
            }
         }
         return;
      }

      public function get parentCanv() : Canvas {
         return this._245198224parentCanv;
      }

      public function set parentCanv(param1:Canvas) : void {
         var _loc2_:Object = this._245198224parentCanv;
         if(_loc2_ !== param1)
         {
            this._245198224parentCanv=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"parentCanv",_loc2_,param1));
            }
         }
         return;
      }

      public function get sliderSpeed() : HSlider {
         return this._69010458sliderSpeed;
      }

      public function set sliderSpeed(param1:HSlider) : void {
         var _loc2_:Object = this._69010458sliderSpeed;
         if(_loc2_ !== param1)
         {
            this._69010458sliderSpeed=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sliderSpeed",_loc2_,param1));
            }
         }
         return;
      }

      public function get stepsSlider() : HSlider {
         return this._591855896stepsSlider;
      }

      public function set stepsSlider(param1:HSlider) : void {
         var _loc2_:Object = this._591855896stepsSlider;
         if(_loc2_ !== param1)
         {
            this._591855896stepsSlider=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"stepsSlider",_loc2_,param1));
            }
         }
         return;
      }

      public function get tileSteps() : Tile {
         return this._861926119tileSteps;
      }

      public function set tileSteps(param1:Tile) : void {
         var _loc2_:Object = this._861926119tileSteps;
         if(_loc2_ !== param1)
         {
            this._861926119tileSteps=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"tileSteps",_loc2_,param1));
            }
         }
         return;
      }

      public function get toolUsed() : Image {
         return this._983548555toolUsed;
      }

      public function set toolUsed(param1:Image) : void {
         var _loc2_:Object = this._983548555toolUsed;
         if(_loc2_ !== param1)
         {
            this._983548555toolUsed=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"toolUsed",_loc2_,param1));
            }
         }
         return;
      }

      public function get uploadProgress() : Text {
         return this._1534483634uploadProgress;
      }

      public function set uploadProgress(param1:Text) : void {
         var _loc2_:Object = this._1534483634uploadProgress;
         if(_loc2_ !== param1)
         {
            this._1534483634uploadProgress=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"uploadProgress",_loc2_,param1));
            }
         }
         return;
      }

      private function get PenCursor() : Class {
         return this._2061379153PenCursor;
      }

      private function set PenCursor(param1:Class) : void {
         var _loc2_:Object = this._2061379153PenCursor;
         if(_loc2_ !== param1)
         {
            this._2061379153PenCursor=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"PenCursor",_loc2_,param1));
            }
         }
         return;
      }

      private function get PenTool() : Class {
         return this._981594673PenTool;
      }

      private function set PenTool(param1:Class) : void {
         var _loc2_:Object = this._981594673PenTool;
         if(_loc2_ !== param1)
         {
            this._981594673PenTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"PenTool",_loc2_,param1));
            }
         }
         return;
      }

      private function get BrushTool() : Class {
         return this._1933731794BrushTool;
      }

      private function set BrushTool(param1:Class) : void {
         var _loc2_:Object = this._1933731794BrushTool;
         if(_loc2_ !== param1)
         {
            this._1933731794BrushTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"BrushTool",_loc2_,param1));
            }
         }
         return;
      }

      private function get PolygonTool() : Class {
         return this._635350482PolygonTool;
      }

      private function set PolygonTool(param1:Class) : void {
         var _loc2_:Object = this._635350482PolygonTool;
         if(_loc2_ !== param1)
         {
            this._635350482PolygonTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"PolygonTool",_loc2_,param1));
            }
         }
         return;
      }

      private function get AirBrushTool() : Class {
         return this._1105139176AirBrushTool;
      }

      private function set AirBrushTool(param1:Class) : void {
         var _loc2_:Object = this._1105139176AirBrushTool;
         if(_loc2_ !== param1)
         {
            this._1105139176AirBrushTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"AirBrushTool",_loc2_,param1));
            }
         }
         return;
      }

      private function get RectangleTool() : Class {
         return this._1944425593RectangleTool;
      }

      private function set RectangleTool(param1:Class) : void {
         var _loc2_:Object = this._1944425593RectangleTool;
         if(_loc2_ !== param1)
         {
            this._1944425593RectangleTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"RectangleTool",_loc2_,param1));
            }
         }
         return;
      }

      private function get CircleTool() : Class {
         return this._882609832CircleTool;
      }

      private function set CircleTool(param1:Class) : void {
         var _loc2_:Object = this._882609832CircleTool;
         if(_loc2_ !== param1)
         {
            this._882609832CircleTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"CircleTool",_loc2_,param1));
            }
         }
         return;
      }

      private function get LineTool() : Class {
         return this._1253300172LineTool;
      }

      private function set LineTool(param1:Class) : void {
         var _loc2_:Object = this._1253300172LineTool;
         if(_loc2_ !== param1)
         {
            this._1253300172LineTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"LineTool",_loc2_,param1));
            }
         }
         return;
      }

      private function get CurveTool() : Class {
         return this._1519653113CurveTool;
      }

      private function set CurveTool(param1:Class) : void {
         var _loc2_:Object = this._1519653113CurveTool;
         if(_loc2_ !== param1)
         {
            this._1519653113CurveTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"CurveTool",_loc2_,param1));
            }
         }
         return;
      }

      private function get SmudgeTool() : Class {
         return this._776332127SmudgeTool;
      }

      private function set SmudgeTool(param1:Class) : void {
         var _loc2_:Object = this._776332127SmudgeTool;
         if(_loc2_ !== param1)
         {
            this._776332127SmudgeTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"SmudgeTool",_loc2_,param1));
            }
         }
         return;
      }

      private function get EraseTool() : Class {
         return this._233360702EraseTool;
      }

      private function set EraseTool(param1:Class) : void {
         var _loc2_:Object = this._233360702EraseTool;
         if(_loc2_ !== param1)
         {
            this._233360702EraseTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"EraseTool",_loc2_,param1));
            }
         }
         return;
      }

      private function get BucketTool() : Class {
         return this._1184301374BucketTool;
      }

      private function set BucketTool(param1:Class) : void {
         var _loc2_:Object = this._1184301374BucketTool;
         if(_loc2_ !== param1)
         {
            this._1184301374BucketTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"BucketTool",_loc2_,param1));
            }
         }
         return;
      }

      private function get Back() : Class {
         return this._2062599Back;
      }

      private function set Back(param1:Class) : void {
         var _loc2_:Object = this._2062599Back;
         if(_loc2_ !== param1)
         {
            this._2062599Back=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"Back",_loc2_,param1));
            }
         }
         return;
      }
   }

}