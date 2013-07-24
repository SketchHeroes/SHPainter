package components
{
   import mx.containers.Canvas;
   import mx.core.UIComponent;
   import com.reinatech.shpainter.components.RButton;
   import mx.controls.Button;
   import mx.controls.CheckBox;
   import mx.controls.ColorPicker;
   import com.reinatech.shpainter.components.RCanvas;
   import mx.containers.VBox;
   import mx.controls.HSlider;
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
   import com.reinatech.shpainter.SHPainterCanvas;
   import asset.DrawingViewTemplate;
   import com.reinatech.shpainter.Settings;
   import mx.core.Application;
   import com.reinatech.shpainter.events.ColorChangedEvent;
   import com.reinatech.shpainter.events.BrushChangedEvent;
   import mx.graphics.ImageSnapshot;
   import mx.events.ColorPickerEvent;
   import com.reinatech.shpainter.utils.ProjectUtils;
   import com.reinatech.shpainter.history.HistoryStack;
   import mx.managers.CursorManager;
   import com.reinatech.shpainter.utils.Printer;
   import mx.managers.PopUpManager;
   import mx.events.FlexEvent;
   import mx.events.SliderEvent;
   import mx.events.PropertyChangeEvent;
   import mx.containers.HBox;
   import mx.controls.Label;
   import mx.containers.Tile;

   use namespace CSSStyleDeclaration;
   use namespace mx_internal;
   use namespace StyleManager;

   public class Drawing extends Canvas
   {
      public function Drawing() {
         this._documentDescriptor_=new UIComponentDescriptor(
            {
               "type":Canvas,
               "events":{"creationComplete":"___Drawing_Canvas1_creationComplete"},
               "stylesFactory":new function():void
               {
                  this.backgroundAlpha=0.0;
                  this.backgroundColor=14218495;
                  return;
                  },
                  "propertiesFactory":new function():Object
                  {
                     return {"childDescriptors":[new UIComponentDescriptor(
                        {
                           "type":Canvas,
                           "id":"mainCanvas",
                           "propertiesFactory":new function():Object
                           {
                              return {
                              "x":0,
                              "y":0,
                              "width":835,
                              "height":640,
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
                                 "type":HSlider,
                                 "id":"sliderOpacity",
                                 "events":{"change":"__sliderOpacity_change"},
                                 "propertiesFactory":new function():Object
                                 {
                                    return {
                                    "x":401,
                                    "y":58,
                                    "width":85,
                                    "height":12,
                                    "value":1,
                                    "minimum":0,
                                    "maximum":1,
                                    "styleName":"opacitySlider",
                                    "sliderThumbClass":CustomThumbCircClass
                                 }
                                 ;
                           }
                        }
                        ),new UIComponentDescriptor(
                        {
                           "type":HSlider,
                           "id":"sliderThickness",
                           "events":{"change":"__sliderThickness_change"},
                           "propertiesFactory":new function():Object
                           {
                                 return {
                                 "x":251,
                                 "y":58,
                                 "width":100,
                                 "height":12,
                                 "value":2,
                                 "minimum":1,
                                 "maximum":50,
                                 "snapInterval":1,
                                 "styleName":"strokeSlider",
                                 "sliderThumbClass":CustomThumbCircClass
                           }
                           ;
                        }
                  }
                  ),new UIComponentDescriptor(
                  {
                        "type":Button,
                        "id":"bHelp",
                        "stylesFactory":new function():void
                        {
                           this.icon=_embed_mxml____assets_drawing_set_close_option_close_option_01_png_148655952;
                           return;
                           },
                           "propertiesFactory":new function():Object
                           {
                                 return {
                                 "x":637,
                                 "y":85,
                                 "width":17,
                                 "height":16,
                                 "visible":false
                           }
                           ;
                        }
                  }
                  ),new UIComponentDescriptor(
                  {
                        "type":Canvas,
                        "id":"right_controls",
                        "propertiesFactory":new function():Object
                        {
                           return {
                           "x":685,
                           "y":54,
                           "width":134,
                           "height":171,
                           "visible":false,
                           "childDescriptors":[new UIComponentDescriptor(
                              {
                                 "type":VBox,
                                 "stylesFactory":new function():void
                                 {
                                    this.verticalGap=10;
                                    return;
                                    },
                                    "propertiesFactory":new function():Object
                                    {
                                       return {
                                       "y":10,
                                       "x":10,
                                       "childDescriptors":[new UIComponentDescriptor(
                                          {
                                             "type":Canvas,
                                             "propertiesFactory":new function():Object
                                             {
                                                return {
                                                "percentWidth":100,
                                                "childDescriptors":[new UIComponentDescriptor(
                                                   {
                                                      "type":VBox,
                                                      "id":"info_pallete",
                                                      "stylesFactory":new function():void
                                                      {
                                                         this.verticalGap=0;
                                                         return;
                                                         },
                                                         "propertiesFactory":new function():Object
                                                         {
                                                            return {
                                                            "horizontalCenter":0,
                                                            "childDescriptors":[new UIComponentDescriptor(
                                                               {
                                                                  "type":Canvas,
                                                                  "stylesFactory":new function():void
                                                                  {
                                                                     this.backgroundColor=16777215;
                                                                     return;
                                                                     },
                                                                     "propertiesFactory":new function():Object
                                                                     {
                                                                        return {
                                                                        "percentWidth":100,
                                                                        "height":70,
                                                                        "childDescriptors":[new UIComponentDescriptor(
                                                                           {
                                                                              "type":VBox,
                                                                              "stylesFactory":new function():void
                                                                              {
                                                                                 this.verticalGap=5;
                                                                                 this.paddingLeft=10;
                                                                                 return;
                                                                                 },
                                                                                 "propertiesFactory":new function():Object
                                                                                 {
                                                                                    return {
                                                                                    "width":119,
                                                                                    "y":10,
                                                                                    "childDescriptors":[new UIComponentDescriptor(
                                                                                       {
                                                                                          "type":HBox,
                                                                                          "propertiesFactory":new function():Object
                                                                                          {
                                                                                             return {"childDescriptors":[new UIComponentDescriptor(
                                                                                                {
                                                                                                   "type":CheckBox,
                                                                                                   "id":"chkShowPencil",
                                                                                                   "propertiesFactory":new function():Object
                                                                                                   {
                                                                                                      return {
                                                                                                      "selected":false,
                                                                                                      "width":17,
                                                                                                      "height":17,
                                                                                                      "styleName":"chkInfo",
                                                                                                      "toolTip":"Show Pencil (H)"
                                                                                                   }
                                                                                                   ;
                                                                                                }
                                                                                          }
                                                                                          ),new UIComponentDescriptor(
                                                                                          {
                                                                                                "type":Label,
                                                                                                "propertiesFactory":new function():Object
                                                                                                {
                                                                                                   return {"text":"Show Pencil"};
                                                                                                }
                                                                                          }
                                                                                          )]};
                                                                                       }
                                                                                 }
                                                                                 ),new UIComponentDescriptor(
                                                                                 {
                                                                                       "type":Canvas,
                                                                                       "stylesFactory":new function():void
                                                                                       {
                                                                                          this.backgroundColor=14606046;
                                                                                          return;
                                                                                          },
                                                                                          "propertiesFactory":new function():Object
                                                                                          {
                                                                                             return {
                                                                                             "height":2,
                                                                                             "percentWidth":90
                                                                                          }
                                                                                          ;
                                                                                       }
                                                                                 }
                                                                                 ),new UIComponentDescriptor(
                                                                                 {
                                                                                       "type":HBox,
                                                                                       "propertiesFactory":new function():Object
                                                                                       {
                                                                                          return {"childDescriptors":[new UIComponentDescriptor(
                                                                                             {
                                                                                                "type":CheckBox,
                                                                                                "id":"chkFullScreen",
                                                                                                "events":{"change":"__chkFullScreen_change"},
                                                                                                "propertiesFactory":new function():Object
                                                                                                {
                                                                                                   return {
                                                                                                   "selected":false,
                                                                                                   "width":17,
                                                                                                   "height":17,
                                                                                                   "styleName":"chkInfo",
                                                                                                   "toolTip":"Full Screen (SHIFT)"
                                                                                                }
                                                                                                ;
                                                                                             }
                                                                                       }
                                                                                       ),new UIComponentDescriptor(
                                                                                       {
                                                                                             "type":Label,
                                                                                             "propertiesFactory":new function():Object
                                                                                             {
                                                                                                return {"text":"Full Screen"};
                                                                                             }
                                                                                       }
                                                                                       )]};
                                                                                 }
                                                                              }
                                                                              )]
                                                                           }
                                                                           ;
                                                                     }
                                                                  }
                                                                  )]
                                                               }
                                                               ;
                                                         }
                                                      }
                                                      )]
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
                                 "type":Canvas,
                                 "propertiesFactory":new function():Object
                                 {
                                    return {
                                    "percentWidth":100,
                                    "visible":false,
                                    "childDescriptors":[new UIComponentDescriptor(
                                       {
                                          "type":VBox,
                                          "id":"layers_pallete",
                                          "stylesFactory":new function():void
                                          {
                                             this.verticalGap=0;
                                             return;
                                             },
                                             "propertiesFactory":new function():Object
                                             {
                                                return {
                                                "horizontalCenter":0,
                                                "childDescriptors":[new UIComponentDescriptor(
                                                   {
                                                      "type":Tile,
                                                      "stylesFactory":new function():void
                                                      {
                                                         this.backgroundColor=16777215;
                                                         return;
                                                         },
                                                         "propertiesFactory":new function():Object
                                                         {
                                                            return {
                                                            "width":119,
                                                            "height":78,
                                                            "direction":"horizontal",
                                                            "childDescriptors":[new UIComponentDescriptor(
                                                               {
                                                                  "type":Canvas,
                                                                  "id":"drawingLayer",
                                                                  "events":{"mouseDown":"__drawingLayer_mouseDown"},
                                                                  "stylesFactory":new function():void
                                                                  {
                                                                     this.backgroundColor=9671571;
                                                                     return;
                                                                     },
                                                                     "propertiesFactory":new function():Object
                                                                     {
                                                                        return {
                                                                        "width":119,
                                                                        "height":20,
                                                                        "childDescriptors":[new UIComponentDescriptor(
                                                                           {
                                                                              "type":CheckBox,
                                                                              "id":"chkDrawingVisibility",
                                                                              "events":{"change":"__chkDrawingVisibility_change"},
                                                                              "propertiesFactory":new function():Object
                                                                              {
                                                                                 return {
                                                                                 "x":5,
                                                                                 "y":5,
                                                                                 "selected":true,
                                                                                 "width":20,
                                                                                 "height":9,
                                                                                 "styleName":"chkLayerVisibility"
                                                                              }
                                                                              ;
                                                                           }
                                                                     }
                                                                     ),new UIComponentDescriptor(
                                                                     {
                                                                           "type":Label,
                                                                           "propertiesFactory":new function():Object
                                                                           {
                                                                              return {
                                                                              "x":40,
                                                                              "text":"Drawing"
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
                                                         "type":Canvas,
                                                         "id":"backgroundLayer",
                                                         "events":{"mouseDown":"__backgroundLayer_mouseDown"},
                                                         "stylesFactory":new function():void
                                                         {
                                                               this.backgroundColor=14474460;
                                                               return;
                                                               },
                                                               "propertiesFactory":new function():Object
                                                               {
                                                                  return {
                                                                  "width":119,
                                                                  "height":20,
                                                                  "childDescriptors":[new UIComponentDescriptor(
                                                                     {
                                                                        "type":CheckBox,
                                                                        "id":"chkBackgroundVisibility",
                                                                        "events":{"change":"__chkBackgroundVisibility_change"},
                                                                        "propertiesFactory":new function():Object
                                                                        {
                                                                           return {
                                                                           "x":5,
                                                                           "y":5,
                                                                           "selected":true,
                                                                           "width":20,
                                                                           "height":9,
                                                                           "styleName":"chkLayerVisibility"
                                                                        }
                                                                        ;
                                                                     }
                                                               }
                                                               ),new UIComponentDescriptor(
                                                               {
                                                                     "type":Label,
                                                                     "propertiesFactory":new function():Object
                                                                     {
                                                                        return {
                                                                        "x":40,
                                                                        "text":"Background"
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
                                                   "type":Canvas,
                                                   "id":"sketchLayer",
                                                   "events":{"mouseDown":"__sketchLayer_mouseDown"},
                                                   "stylesFactory":new function():void
                                                   {
                                                      this.backgroundColor=14474460;
                                                      return;
                                                      },
                                                      "propertiesFactory":new function():Object
                                                      {
                                                         return {
                                                         "width":119,
                                                         "height":20,
                                                         "childDescriptors":[new UIComponentDescriptor(
                                                            {
                                                               "type":CheckBox,
                                                               "id":"chkSketchVisibility",
                                                               "events":{"change":"__chkSketchVisibility_change"},
                                                               "propertiesFactory":new function():Object
                                                               {
                                                                  return {
                                                                  "x":5,
                                                                  "y":5,
                                                                  "selected":true,
                                                                  "width":20,
                                                                  "height":9,
                                                                  "styleName":"chkLayerVisibility"
                                                               }
                                                               ;
                                                            }
                                                      }
                                                      ),new UIComponentDescriptor(
                                                      {
                                                            "type":Label,
                                                            "propertiesFactory":new function():Object
                                                            {
                                                               return {
                                                               "x":40,
                                                               "text":"Sketch"
                                                            }
                                                            ;
                                                      }
                                                   }
                                                   )]
                                             }
                                             ;
                                          }
                                       }
                                       )]
                                 }
                                 ;
                              }
                        }
                        )]
                  }
                  ;
               }
            }
            )]
         }
         ;
         }
         }
         )]
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
         "type":ColorPicker,
         "id":"cpForegroundColor",
         "events":{"change":"__cpForegroundColor_change"},
         "stylesFactory":new function():void
         {
         this.focusThickness=0;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":2,
         "y":404,
         "width":70,
         "height":68
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":Canvas,
         "id":"parentCanv",
         "events":
         {
         "mouseOver":"__parentCanv_mouseOver",
         "mouseOut":"__parentCanv_mouseOut"
         }
         ,
         "propertiesFactory":new function():Object
         {
         return {
         "x":85,
         "y":77,
         "maxWidth":529,
         "minWidth":529,
         "maxHeight":389,
         "minHeight":389,
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
               "type":RCanvas,
               "id":"drawingCanvas",
               "propertiesFactory":new function():Object
               {
                  return {
                  "x":0,
                  "y":0,
                  "width":529,
                  "height":389,
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
         "type":BrushChooser,
         "id":"brushChooser",
         "propertiesFactory":new function():Object
         {
         return {
         "x":620,
         "y":228
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":ColorSwatcher,
         "id":"colorSwatcher",
         "propertiesFactory":new function():Object
         {
         return {
         "x":1,
         "y":483
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
         "type":RButton,
         "id":"bPenTool",
         "events":{"click":"__bPenTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_pencil_png_1979317486;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-70,
         "y":102,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolClassName":"com.reinatech.shpainter.tools.PenTool",
         "toolTip":"Pencil (P)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":RButton,
         "id":"bBrushTool",
         "events":{"click":"__bBrushTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_brush_png_2032237938;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-40,
         "y":102,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolClassName":"com.reinatech.shpainter.tools.BrushTool",
         "toolTip":"Brush (B)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":RButton,
         "id":"bPolygonTool",
         "events":{"click":"__bPolygonTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_broken_line_png_860816940;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-70,
         "y":132,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolClassName":"com.reinatech.shpainter.tools.PolygonTool",
         "toolTip":"Polygon (W)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":RButton,
         "id":"bAirBrushTool",
         "events":{"click":"__bAirBrushTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_spray_can_png_1941504016;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-40,
         "y":132,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolClassName":"com.reinatech.shpainter.tools.AirBrushTool",
         "toolTip":"Spray (S)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":RButton,
         "id":"bRectangleTool",
         "events":{"click":"__bRectangleTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_squer_png_509948910;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-70,
         "y":162,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolClassName":"com.reinatech.shpainter.tools.RectangleTool",
         "toolTip":"Square (Q)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":RButton,
         "id":"bCircleTool",
         "events":{"click":"__bCircleTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_igul_png_2036994706;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-40,
         "y":162,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolClassName":"com.reinatech.shpainter.tools.CircleTool",
         "toolTip":"Circle (C)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":RButton,
         "id":"bLineTool",
         "events":{"click":"__bLineTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_line_png_2124343008;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-70,
         "y":192,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolClassName":"com.reinatech.shpainter.tools.LineTool",
         "toolTip":"Line (L)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":RButton,
         "id":"bCurveTool",
         "events":{"click":"__bCurveTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_blue_line_png_1674178574;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-40,
         "y":192,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolClassName":"com.reinatech.shpainter.tools.CurveTool",
         "toolTip":"Bending Line (K)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":RButton,
         "id":"bSmudgeTool",
         "events":{"click":"__bSmudgeTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_move_png_378793254;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-70,
         "y":222,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolClassName":"com.reinatech.shpainter.tools.SmudgeTool",
         "toolTip":"Smudge (A)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":RButton,
         "id":"bEraseTool",
         "events":{"click":"__bEraseTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_erase_png_1631341146;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-40,
         "y":222,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolClassName":"com.reinatech.shpainter.tools.EraseTool",
         "toolTip":"Eraser (E)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":Button,
         "id":"bColorPicker",
         "events":{"click":"__bColorPicker_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_knife_png_1218627936;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-70,
         "y":252,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolTip":"Eyedropper (I)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":Button,
         "id":"bGridVisibility",
         "events":{"click":"__bGridVisibility_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_loyodea_png_1137205468;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-40,
         "y":252,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolTip":"Grid (G)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":Button,
         "id":"bZoomPan",
         "events":{"click":"__bZoomPan_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_finger_png_1623712714;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-70,
         "y":302,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolTip":"Grab (SPACE)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":RButton,
         "id":"bFillTool",
         "events":{"click":"__bFillTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_bucket_png_1848910796;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-40,
         "y":302,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolClassName":"com.reinatech.shpainter.tools.BucketTool",
         "toolTip":"Fill (F)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":Button,
         "id":"bUndo",
         "events":{"click":"__bUndo_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_undo_png_1049814784;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-70,
         "y":332,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolTip":"Undo (Ctrl + Z)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":Button,
         "id":"bRedoTool",
         "events":{"click":"__bRedoTool_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_redo_png_110488844;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-40,
         "y":332,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolTip":"Redo (Ctrl + Alt + Z)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":Button,
         "id":"bZoomIn",
         "events":{"click":"__bZoomIn_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_zoom_in_png_1224049970;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-70,
         "y":362,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolTip":"Zoom In (+)"
         }
         ;
         }
         }
         ),new UIComponentDescriptor(
         {
         "type":Button,
         "id":"bZoomOut",
         "events":{"click":"__bZoomOut_click"},
         "stylesFactory":new function():void
         {
         this.icon=_embed_mxml____assets_drawing_tools_icons_zoom_out_png_1752007302;
         return;
         },
         "propertiesFactory":new function():Object
         {
         return {
         "x":-40,
         "y":362,
         "width":30,
         "height":30,
         "styleName":"bTool",
         "buttonMode":true,
         "toolTip":"Zoom Out (-)"
         }
         ;
         }
         }
         )]};
         }
         }
         );
         this._2061379153PenCursor=Drawing_PenCursor;
         this.helpDrawPopUp=new HelpDrawPopUp();
         this.extWarningPopUp=new MissedExtensionWarning();
         this._embed_mxml____assets_drawing_tools_icons_pencil_png_1979317486=Drawing__embed_mxml____assets_drawing_tools_icons_pencil_png_1979317486;
         this._embed_css____assets_drawing_palette_swatches_pen_jpg_2042738765_1442896911=_class_embed_css____assets_drawing_palette_swatches_pen_jpg_2042738765_1442896911;
         this._embed_mxml____assets_drawing_tools_icons_zoom_in_png_1224049970=Drawing__embed_mxml____assets_drawing_tools_icons_zoom_in_png_1224049970;
         this._embed_mxml____assets_drawing_tools_icons_broken_line_png_860816940=Drawing__embed_mxml____assets_drawing_tools_icons_broken_line_png_860816940;
         this._embed_mxml____assets_drawing_tools_icons_undo_png_1049814784=Drawing__embed_mxml____assets_drawing_tools_icons_undo_png_1049814784;
         this._embed_css____assets_drawing_palette_info_del_check_jpg__260650370_1872988606=_class_embed_css____assets_drawing_palette_info_del_check_jpg__260650370_1872988606;
         this._embed_css____assets_drawing_slider_opacity_button_PNG__1695852627_727782515=_class_embed_css____assets_drawing_slider_opacity_button_PNG__1695852627_727782515;
         this._embed_mxml____assets_drawing_tools_icons_bucket_png_1848910796=Drawing__embed_mxml____assets_drawing_tools_icons_bucket_png_1848910796;
         this._embed_css____assets_drawing_palette_swatches_fil_jpg_1870306109_737407871=_class_embed_css____assets_drawing_palette_swatches_fil_jpg_1870306109_737407871;
         this._embed_css____assets_drawing_palette_swatches_fil_uncheck_jpg__21679745_1180792637=_class_embed_css____assets_drawing_palette_swatches_fil_uncheck_jpg__21679745_1180792637;
         this._embed_css____assets_drawing_tools_icons_tool_botton_over_png__1597897019_958623879=_class_embed_css____assets_drawing_tools_icons_tool_botton_over_png__1597897019_958623879;
         this._embed_mxml____assets_drawing_tools_icons_blue_line_png_1674178574=Drawing__embed_mxml____assets_drawing_tools_icons_blue_line_png_1674178574;
         this._embed_mxml____assets_drawing_tools_icons_brush_png_2032237938=Drawing__embed_mxml____assets_drawing_tools_icons_brush_png_2032237938;
         this._embed_mxml____assets_drawing_tools_icons_redo_png_110488844=Drawing__embed_mxml____assets_drawing_tools_icons_redo_png_110488844;
         this._embed_mxml____assets_drawing_tools_icons_erase_png_1631341146=Drawing__embed_mxml____assets_drawing_tools_icons_erase_png_1631341146;
         this._embed_css____assets_drawing_palette_info_del_1_jpg__805051737_1598899109=_class_embed_css____assets_drawing_palette_info_del_1_jpg__805051737_1598899109;
         this._embed_css____assets_drawing_slider_stroke_line_PNG_756335206_405040870=_class_embed_css____assets_drawing_slider_stroke_line_PNG_756335206_405040870;
         this._embed_css____assets_drawing_slider_opacity_line_PNG_1314965359_284293905=_class_embed_css____assets_drawing_slider_opacity_line_PNG_1314965359_284293905;
         this._embed_mxml____assets_drawing_tools_icons_squer_png_509948910=Drawing__embed_mxml____assets_drawing_tools_icons_squer_png_509948910;
         this._embed_mxml____assets_drawing_tools_icons_loyodea_png_1137205468=Drawing__embed_mxml____assets_drawing_tools_icons_loyodea_png_1137205468;
         this._embed_mxml____assets_drawing_tools_icons_line_png_2124343008=Drawing__embed_mxml____assets_drawing_tools_icons_line_png_2124343008;
         this._embed_mxml____assets_drawing_tools_icons_knife_png_1218627936=Drawing__embed_mxml____assets_drawing_tools_icons_knife_png_1218627936;
         this._embed_css____assets_drawing_palette_lay_eye_png_118764447_435901823=_class_embed_css____assets_drawing_palette_lay_eye_png_118764447_435901823;
         this._embed_mxml____assets_drawing_tools_icons_finger_png_1623712714=Drawing__embed_mxml____assets_drawing_tools_icons_finger_png_1623712714;
         this._embed_css____assets_drawing_palette_swatches_pen_uncheck_jpg__690602353_788560077=_class_embed_css____assets_drawing_palette_swatches_pen_uncheck_jpg__690602353_788560077;
         this._embed_mxml____assets_drawing_tools_icons_move_png_378793254=Drawing__embed_mxml____assets_drawing_tools_icons_move_png_378793254;
         this._embed_css____assets_drawing_tools_icons_tool_botton_png_78593253_325737899=_class_embed_css____assets_drawing_tools_icons_tool_botton_png_78593253_325737899;
         this._embed_mxml____assets_drawing_set_close_option_close_option_01_png_148655952=Drawing__embed_mxml____assets_drawing_set_close_option_close_option_01_png_148655952;
         this._embed_css____assets_drawing_slider_stroke_button_PNG__1668517660_542213352=_class_embed_css____assets_drawing_slider_stroke_button_PNG__1668517660_542213352;
         this._embed_mxml____assets_drawing_tools_icons_spray_can_png_1941504016=Drawing__embed_mxml____assets_drawing_tools_icons_spray_can_png_1941504016;
         this._embed_css____assets_drawing_palette_lay_eye_uncheck_png__1130360863_1158331233=_class_embed_css____assets_drawing_palette_lay_eye_uncheck_png__1130360863_1158331233;
         this._embed_mxml____assets_drawing_tools_icons_zoom_out_png_1752007302=Drawing__embed_mxml____assets_drawing_tools_icons_zoom_out_png_1752007302;
         this._embed_mxml____assets_drawing_tools_icons_igul_png_2036994706=Drawing__embed_mxml____assets_drawing_tools_icons_igul_png_2036994706;
         super();
         mx_internal::_document=this;
         this.addEventListener("creationComplete",this.___Drawing_Canvas1_creationComplete);
         return;
      }

      public static const OPEN_EDITOR:String = "openEditor";

      private var _91266652_skin:UIComponent;

      private var _1878551734bAirBrushTool:RButton;

      private var _144722512bBrushTool:RButton;

      private var _875035786bCircleTool:RButton;

      private var _1976187889bColorPicker:Button;

      private var _696859877bCurveTool:RButton;

      private var _1845093604bEraseTool:RButton;

      private var _1701299139bFillTool:RButton;

      private var _2090165242bGridVisibility:Button;

      private var _92750531bHelp:Button;

      private var _216421934bLineTool:RButton;

      private var _21684337bPenTool:RButton;

      private var _400555056bPolygonTool:RButton;

      private var _50436709bRectangleTool:RButton;

      private var _1743721672bRedoTool:Button;

      private var _768758081bSmudgeTool:RButton;

      private var _93146214bUndo:Button;

      private var _536404134bZoomIn:Button;

      private var _551347129bZoomOut:Button;

      private var _551347464bZoomPan:Button;

      private var _1295031491backgroundLayer:Canvas;

      private var _1135319201brushChooser:BrushChooser;

      private var _348674214chkBackgroundVisibility:CheckBox;

      private var _683001290chkDrawingVisibility:CheckBox;

      private var _550261471chkFullScreen:CheckBox;

      private var _939042736chkShowPencil:CheckBox;

      private var _1563106468chkSketchVisibility:CheckBox;

      private var _1184727660colorSwatcher:ColorSwatcher;

      private var _2145307571cpForegroundColor:ColorPicker;

      private var _999717098drawingCanvas:RCanvas;

      private var _716663853drawingLayer:Canvas;

      private var _503646772info_pallete:VBox;

      private var _892426552layers_pallete:VBox;

      private var _10782607mainCanvas:Canvas;

      private var _245198224parentCanv:Canvas;

      private var _1832561287right_controls:Canvas;

      private var _1185643259sketchLayer:Canvas;

      private var _1153333270sliderOpacity:HSlider;

      private var _1050086291sliderThickness:HSlider;

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
            this.backgroundColor=14218495;
            return;
         };
         mx_internal::_Drawing_StylesInit();
         return;
      }

      override public function initialize() : void {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
         return;
      }

      private var _pc:SHPainterCanvas;

      private var _template:DrawingViewTemplate;

      private var _2061379153PenCursor:Class;

      private var _compilePenTool:PenTool;

      private var _compileLineTool:LineTool;

      private var _compileRectangleTool:RectangleTool;

      private var _compileCircleTool:CircleTool;

      private var _compileSprayTool:AirBrushTool;

      private var _compileEraseTool:EraseTool;

      private var _compileBrushTool:BrushTool;

      private var _compilePolygonTool:PolygonTool;

      private var _compileSmudgeTool:SmudgeTool;

      private var _compileBucketTool:BucketTool;

      private var _prevActiveTool:RButton;

      public var thumb:Bitmap;

      private function init() : void {
         this._template=new DrawingViewTemplate();
         this._skin.addChild(this._template);
         this.initSkin();
         this._pc=new SHPainterCanvas(this.drawingCanvas);
         this._pc.activeTool=new PenTool(Settings.getInstance().getDrawingSettings().clone());
         this.bPenTool.enabled=false;
         this._prevActiveTool=this.bPenTool;
         this._pc.activeBrush=0;
         this._pc.setActiveBitmapData(SHPainterCanvas.DRAWING);
         if(Application.application.parameters.adm != "1")
         {
            this._template.bUploadSketch.visible=false;
         }
         this.colorSwatcher.addEventListener(ColorChangedEvent.CHANGE,this.swatchColorChanged);
         this.brushChooser.addEventListener(BrushChangedEvent.CHANGE,this.brushChanged);
         Application.application.addEventListener(KeyboardEvent.KEY_DOWN,this.keyHandler);
         Application.application.addEventListener(KeyboardEvent.KEY_UP,this.upKeyHandler);
         Application.application.setFocus();
         return;
      }

      private function initSkin() : void {
         this._aClass=[];
         this._aClass["bPenTool"]="com.reinatech.shpainter.tools.PenTool";
         this._aClass["bBrushTool"]="com.reinatech.shpainter.tools.BrushTool";
         this._aClass["bPolygonTool"]="com.reinatech.shpainter.tools.PolygonTool";
         this._aClass["bAirBrushTool"]="com.reinatech.shpainter.tools.AirBrushTool";
         this._aClass["bRectangleTool"]="com.reinatech.shpainter.tools.RectangleTool";
         this._aClass["bCircleTool"]="com.reinatech.shpainter.tools.CircleTool";
         this._aClass["bLineTool"]="com.reinatech.shpainter.tools.LineTool";
         this._aClass["bCurveTool"]="com.reinatech.shpainter.tools.CurveTool";
         this._aClass["bSmudgeTool"]="com.reinatech.shpainter.tools.SmudgeTool";
         this._aClass["bEraseTool"]="com.reinatech.shpainter.tools.EraseTool";
         this._aClass["bFillTool"]="com.reinatech.shpainter.tools.BucketTool";
         this._template.bPenTool.addEventListener(MouseEvent.CLICK,this.toolClickedSkin);
         this._template.bBrushTool.addEventListener(MouseEvent.CLICK,this.toolClickedSkin);
         this._template.bAirBrushTool.addEventListener(MouseEvent.CLICK,this.toolClickedSkin);
         this._template.bCircleTool.addEventListener(MouseEvent.CLICK,this.toolClickedSkin);
         this._template.bColorPicker.addEventListener(MouseEvent.CLICK,this.pickColor);
         this._template.bCurveTool.addEventListener(MouseEvent.CLICK,this.toolClickedSkin);
         this._template.bEraseTool.addEventListener(MouseEvent.CLICK,this.toolClickedSkin);
         this._template.bFillTool.addEventListener(MouseEvent.CLICK,this.toolClickedSkin);
         this._template.bLineTool.addEventListener(MouseEvent.CLICK,this.toolClickedSkin);
         this._template.bPolygonTool.addEventListener(MouseEvent.CLICK,this.toolClickedSkin);
         this._template.bRectangleTool.addEventListener(MouseEvent.CLICK,this.toolClickedSkin);
         this._template.bSmudgeTool.addEventListener(MouseEvent.CLICK,this.toolClickedSkin);
         this._template.bRedoTool.addEventListener(MouseEvent.CLICK,this.redo);
         this._template.bUndo.addEventListener(MouseEvent.CLICK,this.undo);
         this._template.bZoomIn.addEventListener(MouseEvent.CLICK,this.zoomIn);
         this._template.bZoomOut.addEventListener(MouseEvent.CLICK,this.zoomOut);
         this._template.bZoomPan.addEventListener(MouseEvent.CLICK,this.zoomDragging);
         this._template.bNewDrawing.addEventListener(MouseEvent.CLICK,this.clearCanvas);
         this._template.bOpenDrawing.addEventListener(MouseEvent.CLICK,this.onOpenClick);
         this._template.bSaveDrawing.addEventListener(MouseEvent.CLICK,this.onSaveClick);
         this._template.bUploadSketch.addEventListener(MouseEvent.CLICK,this.onLoadSketchClick);
         this._template.bPrint.addEventListener(MouseEvent.CLICK,this.printPaint);
         this._template.bHelp.addEventListener(MouseEvent.CLICK,this.showHelpDrawPopUp);
         this._template.bCreateTutorial.addEventListener(MouseEvent.CLICK,this.nextSteep);
         this._drawing=new CheckButton(this._template.drawing,"Drawing",true);
         this._backing=new CheckButton(this._template.back,"Background",false);
         this._sketching=new CheckButton(this._template.sketch,"Sketch",false);
         var _loc1_:* = new CheckButton(this._template.eyeDrawing,"",true);
         var _loc2_:* = new CheckButton(this._template.eyeBack,"",true);
         var _loc3_:* = new CheckButton(this._template.eyeSketch,"",true);
         this._drawing.addEventListener(Event.CHANGE,this.onChangeDrawind,false,0,true);
         this._backing.addEventListener(Event.CHANGE,this.onChangeBacking,false,0,true);
         this._sketching.addEventListener(Event.CHANGE,this.onChangeSketching,false,0,true);
         _loc1_.addEventListener(Event.CHANGE,this.onChangeYDrawind,false,0,true);
         _loc2_.addEventListener(Event.CHANGE,this.onChangeYBack,false,0,true);
         _loc3_.addEventListener(Event.CHANGE,this.onChangeYSketch,false,0,true);
         this._cFullScreen=new CheckButton(this._template.checkFull,"Full screen",false);
         this._cFullScreen.addEventListener(Event.CHANGE,this.onChangeFullScreen,false,0,true);
         this._cGrid=new CheckButton(this._template.checkGrid,"Grid",!this._template.grid.visible);
         this._cGrid.addEventListener(Event.CHANGE,this.onChangeGrid,false,0,true);
         return;
      }

      private function onChangeDrawind(param1:Event) : void {
         if(this._drawing.state)
         {
            this._pc.setActiveBitmapData(SHPainterCanvas.DRAWING);
            this._backing.state=false;
            this._sketching.state=false;
         }
         return;
      }

      private function onChangeBacking(param1:Event) : void {
         if(this._backing.state)
         {
            this._pc.setActiveBitmapData(SHPainterCanvas.BACKGROUND);
            this._drawing.state=false;
            this._sketching.state=false;
         }
         return;
      }

      private function onChangeSketching(param1:Event) : void {
         if(this._sketching.state)
         {
            this._pc.setActiveBitmapData(SHPainterCanvas.SKETCH);
            this._drawing.state=false;
            this._backing.state=false;
         }
         return;
      }

      private function onChangeYSketch(param1:Event) : void {
         SHPainterCanvas.getInstance().setLayerVisibility(0,(param1.target as CheckButton).state);
         return;
      }

      private function onChangeYBack(param1:Event) : void {
         SHPainterCanvas.getInstance().setLayerVisibility(1,(param1.target as CheckButton).state);
         return;
      }

      private function onChangeYDrawind(param1:Event) : void {
         SHPainterCanvas.getInstance().setLayerVisibility(2,(param1.target as CheckButton).state);
         return;
      }

      private function onChangeGrid(param1:Event) : void {
         this._template.grid.visible=!this._cGrid.state;
         return;
      }

      private function onChangeFullScreen(param1:Event) : void {
         if(this._cFullScreen.state)
         {
            stage.displayState=StageDisplayState.FULL_SCREEN;
            this.mainCanvas.scaleY=this.mainCanvas.scaleX=stage.height / this.mainCanvas.height;
            stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.fullScreenHandler);
            this.mainCanvas.setStyle("backgroundColor",14218495);
         }
         else
         {
            stage.displayState=StageDisplayState.NORMAL;
            this.mainCanvas.scaleY=this.mainCanvas.scaleX=1;
            this.mainCanvas.setStyle("backgroundColor",null);
         }
         return;
      }

      private function nextSteep(param1:MouseEvent) : void {
         if(stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            stage.displayState=StageDisplayState.NORMAL;
            this.mainCanvas.scaleY=this.mainCanvas.scaleX=1;
            this.mainCanvas.setStyle("backgroundColor",null);
            this._cFullScreen.state=false;
         }
         this.createThumbnail();
         this.createTutorial();
         return;
      }

      private function zoomOut(param1:MouseEvent) : void {
         this.zoom("out");
         return;
      }

      private function zoomIn(param1:MouseEvent) : void {
         this.zoom("in");
         return;
      }

      private function toolClickedSkin(param1:MouseEvent) : void {
         var ToolClass:Class = null;
         var event:MouseEvent = param1;
         if(this._prevActiveToolSkin == event.target.name)
         {
            return;
         }
         this._prevActiveToolSkin=event.target.name;
         try
         {
            ToolClass=getDefinitionByName(this._aClass[event.target.name]) as Class;
         }
         catch(err:Error)
         {
            return;
         }
         this._pc.activeTool=new ToolClass(Settings.getInstance().getDrawingSettings().clone());
         if(this._pc.activeTool  is  BrushTool)
         {
            this.sliderThickness.value=15;
         }
         else
         {
            if(this._pc.activeTool  is  BucketTool)
            {
               this.sliderThickness.value=3;
            }
            else
            {
               this.sliderThickness.value=2;
            }
         }
         this.changeThickness();
         return;
      }

      private function createThumbnail() : void {
         SHPainterCanvas.getInstance().setLayerVisibility(0,false);
         this.thumb=new Bitmap(ImageSnapshot.captureBitmapData(this.drawingCanvas));
         SHPainterCanvas.getInstance().setLayerVisibility(0,true);
         return;
      }

      private function swatchColorChanged(param1:ColorChangedEvent) : void {
         this.cpForegroundColor.selectedColor=param1.color;
         Settings.getInstance().getDrawingSettings().setForegroundColor(this.cpForegroundColor.selectedColor as uint);
         return;
      }

      private function toolClicked(param1:MouseEvent) : void {
         var ToolClass:Class = null;
         var event:MouseEvent = param1;
         if(this._prevActiveTool)
         {
            this._prevActiveTool.enabled=true;
         }
         if(!this.bColorPicker.enabled || !this.bZoomPan.enabled)
         {
            this.bColorPicker.enabled=true;
            this.bZoomPan.enabled=true;
            this._pc.unlock();
         }
         var toolClicked:RButton = event.target as RButton;
         toolClicked.enabled=false;
         this._prevActiveTool=toolClicked;
         try
         {
            ToolClass=getDefinitionByName(toolClicked.toolClassName) as Class;
         }
         catch(err:Error)
         {
            return;
         }
         this._pc.activeTool=new ToolClass(Settings.getInstance().getDrawingSettings().clone());
         if(this._pc.activeTool  is  BrushTool)
         {
            this.sliderThickness.value=15;
         }
         else
         {
            if(this._pc.activeTool  is  BucketTool)
            {
               this.sliderThickness.value=3;
            }
            else
            {
               this.sliderThickness.value=2;
            }
         }
         this.changeThickness();
         return;
      }

      private function undo(param1:MouseEvent=null) : void {
         this._pc.undoState();
         return;
      }

      private function redo(param1:MouseEvent=null) : void {
         this._pc.redoState();
         return;
      }

      private function changeForegroundColor(param1:ColorPickerEvent) : void {
         Settings.getInstance().getDrawingSettings().setForegroundColor(param1.currentTarget.selectedItem as uint);
         return;
      }

      private function changeThickness() : void {
         Settings.getInstance().getDrawingSettings().setLineThickness(this.sliderThickness.value);
         return;
      }

      private function changeOpacity() : void {
         Settings.getInstance().getDrawingSettings().setOpacity(this.sliderOpacity.value);
         return;
      }

      private function brushChanged(param1:BrushChangedEvent) : void {
         this._template.bBrushTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
         this._pc.activeBrush=param1.brushIndex;
         return;
      }

      private function clearCanvas(param1:MouseEvent=null) : void {
         this._pc.clear();
         this._pc.setActiveBitmapData(SHPainterCanvas.DRAWING);
         return;
      }

      private function zoom(param1:String) : void {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         if(param1 == "in")
         {
            if(Settings.SCALE <= 5)
            {
               _loc2_=this.drawingCanvas.x;
               _loc3_=this.drawingCanvas.y;
               Settings.SCALE=Settings.SCALE + 1;
               this.drawingCanvas.scaleX=this.drawingCanvas.scaleY=Settings.SCALE;
               this.drawingCanvas.x=_loc2_ - this.drawingCanvas.width / Settings.SCALE / 4;
               this.drawingCanvas.y=_loc3_ - this.drawingCanvas.height / Settings.SCALE / 4;
            }
         }
         else
         {
            if(param1 == "out")
            {
               if(Settings.SCALE > 2)
               {
                  _loc2_=this.drawingCanvas.x;
                  _loc3_=this.drawingCanvas.y;
                  Settings.SCALE=Settings.SCALE-1;
                  this.drawingCanvas.scaleX=this.drawingCanvas.scaleY=Settings.SCALE;
                  this.drawingCanvas.x=_loc2_ + this.drawingCanvas.width / Settings.SCALE / 4;
                  this.drawingCanvas.y=_loc3_ + this.drawingCanvas.height / Settings.SCALE / 4;
               }
               else
               {
                  Settings.SCALE=1;
                  this.drawingCanvas.scaleX=this.drawingCanvas.scaleY=Settings.SCALE;
                  this.drawingCanvas.x=0;
                  this.drawingCanvas.y=0;
               }
            }
         }
         return;
      }

      private function onSaveProject() : void {
         var _loc1_:ProjectUtils = new ProjectUtils();
         _loc1_.exportProject();
         return;
      }

      private function onSaveClick(param1:MouseEvent=null) : void {
         this.showExtWarningPopUp();
         return;
      }

      private function onOpenClick(param1:MouseEvent=null) : void {
         var _loc2_:ProjectUtils = new ProjectUtils();
         this.currInitTool=0;
         SHPainterCanvas.getInstance().lockBitmaps();
         this.drawingCanvas.visible=false;
         _loc2_.addEventListener(ProjectUtils.PROJECT_LOADED,this.onProjectLoaded);
         _loc2_.addEventListener(Event.CANCEL,this.onProjectCancel);
         _loc2_.importProject(false);
         return;
      }

      private function onProjectCancel(param1:Event) : void {
         this.uploadProgress.visible=false;
         this.drawingCanvas.visible=true;
         SHPainterCanvas.getInstance().unlockBitmaps();
         return;
      }

      private function onProjectLoaded(param1:Event) : void {
         this.uploadProgress.text="0%";
         this.uploadProgress.visible=true;
         this.totalToolsToInit=HistoryStack.getInstance().getToolsCount();
         stage.addEventListener(Event.ENTER_FRAME,this.initDrawing);
         return;
      }

      private var currInitTool:int = 0;

      private var totalToolsToInit:int = 0;

      private var isInitBusy:Boolean = false;

      private function initDrawing(param1:Event) : void {
         var _loc3_:DrawingTool = null;
         if(this.isInitBusy)
         {
            return;
         }
         this.isInitBusy=true;
         var _loc2_:HistoryStack = HistoryStack.getInstance();
         var _loc4_:* = 0;
         while(_loc2_.hasNextTool())
         {
            _loc3_=_loc2_.next() as DrawingTool;
            SHPainterCanvas.getInstance().setActiveBitmapData(_loc3_.getLayerIndex());
            _loc3_.draw(SHPainterCanvas.getInstance().getActiveBitmapData(),true,false);
            this.currInitTool++;
            this.uploadProgress.text=int(this.currInitTool * 100 / this.totalToolsToInit) + "%";
            _loc4_++;
         }
         stage.removeEventListener(Event.ENTER_FRAME,this.initDrawing);
         this.uploadProgress.visible=false;
         this.drawingCanvas.visible=true;
         SHPainterCanvas.getInstance().unlockBitmaps();
         this.isInitBusy=false;
         this.isInitBusy=false;
         return;
      }

      private function onLoadSketchClick(param1:MouseEvent=null) : void {
         if(Application.application.parameters.adm != "1")
         {
            return;
         }
         var _loc2_:ProjectUtils = new ProjectUtils();
         _loc2_.importSketch();
         return;
      }

      private function pickColor(param1:MouseEvent=null) : void {
         this.bZoomPan.enabled=true;
         this.bColorPicker.enabled=false;
         this._prevActiveTool.enabled=true;
         this._prevActiveToolSkin=param1.target.name;
         this._pc.lock();
         this.drawingCanvas.addEventListener(MouseEvent.CLICK,this.onPickerMouseClicked);
         return;
      }

      private var _isZoomDragging:Boolean = false;

      private var tempMousePoint:Point;

      private function zoomDragging(param1:MouseEvent=null) : void {
         if(Settings.SCALE == 1)
         {
            return;
         }
         this.bColorPicker.enabled=true;
         this.bZoomPan.enabled=false;
         this._prevActiveTool.enabled=true;
         this._pc.lock();
         this.drawingCanvas.clearEvents();
         this.drawingCanvas.addEventListener(MouseEvent.MOUSE_DOWN,this.onZoomDragMouseDown);
         this.drawingCanvas.addEventListener(MouseEvent.MOUSE_MOVE,this.onZoomDragMouseMove);
         this.drawingCanvas.addEventListener(MouseEvent.MOUSE_UP,this.onZoomDragMouseUp);
         this.drawingCanvas.addEventListener(MouseEvent.MOUSE_OUT,this.onZoomDragMouseUp);
         return;
      }

      private function onZoomDragMouseDown(param1:MouseEvent) : void {
         this._isZoomDragging=true;
         this.tempMousePoint=new Point(param1.localX,param1.localY);
         return;
      }

      private function onZoomDragMouseMove(param1:MouseEvent) : void {
         var _loc2_:Point = null;
         if(this._isZoomDragging)
         {
            _loc2_=new Point(param1.localX,param1.localY);
            this.drawingCanvas.x=this.drawingCanvas.x + (_loc2_.x - this.tempMousePoint.x);
            this.drawingCanvas.y=this.drawingCanvas.y + (_loc2_.y - this.tempMousePoint.y);
            this.tempMousePoint=_loc2_;
         }
         return;
      }

      private function onZoomDragMouseUp(param1:MouseEvent) : void {
         this._isZoomDragging=false;
         return;
      }

      private function onPickerMouseClicked(param1:MouseEvent) : void {
         var _loc2_:BitmapData = new BitmapData(this.drawingCanvas.width,this.drawingCanvas.height,true,0);
         _loc2_.draw(this.drawingCanvas);
         this.cpForegroundColor.selectedColor=_loc2_.getPixel32(param1.localX,param1.localY);
         Settings.getInstance().getDrawingSettings().setForegroundColor(this.cpForegroundColor.selectedColor);
         _loc2_.dispose();
         _loc2_=null;
         return;
      }

      private function cpBackgroundColorOpen() : void {
         return;
      }

      private function onNoColorSet() : void {
         return;
      }

      private function cpBackgroundColorClose() : void {
         return;
      }

      private function changeBackgroundColor(param1:ColorPickerEvent) : void {
         return;
      }

      private function changeGridVisibility() : void {
         return;
      }

      private function setFullScreenMode() : void {
         if(stage.displayState == StageDisplayState.NORMAL)
         {
            stage.displayState=StageDisplayState.FULL_SCREEN;
            this.mainCanvas.scaleY=this.mainCanvas.scaleX=stage.height / this.mainCanvas.height;
            stage.addEventListener(FullScreenEvent.FULL_SCREEN,this.fullScreenHandler);
            this.chkFullScreen.selected=true;
         }
         else
         {
            stage.displayState=StageDisplayState.NORMAL;
            this.mainCanvas.scaleY=this.mainCanvas.scaleX=1;
            this.chkFullScreen.selected=false;
         }
         return;
      }

      private function fullScreenHandler(param1:FullScreenEvent) : void {
         if(!param1.fullScreen)
         {
            this.mainCanvas.scaleY=this.mainCanvas.scaleX=1;
            this.chkFullScreen.selected=false;
            this._cFullScreen.state=false;
            this.mainCanvas.setStyle("backgroundColor",null);
         }
         return;
      }

      private function setLayerVisibility(param1:int) : void {
         var _loc2_:* = false;
         if(param1 == 0)
         {
            _loc2_=this.chkSketchVisibility.selected;
         }
         if(param1 == 1)
         {
            _loc2_=this.chkBackgroundVisibility.selected;
         }
         if(param1 == 2)
         {
            _loc2_=this.chkDrawingVisibility.selected;
         }
         SHPainterCanvas.getInstance().setLayerVisibility(param1,_loc2_);
         return;
      }

      private function layerClicked(param1:MouseEvent) : void {
         if(param1.target  is  CheckBox)
         {
            return;
         }
         var _loc2_:Canvas = param1.currentTarget as Canvas;
         if(_loc2_)
         {
            switch(_loc2_.id)
            {
               case "drawingLayer":
                  this.backgroundLayer.setStyle("backgroundColor","0xdcdcdc");
                  this.sketchLayer.setStyle("backgroundColor","0xdcdcdc");
                  this.drawingLayer.setStyle("backgroundColor","0x939393");
                  this._pc.setActiveBitmapData(SHPainterCanvas.DRAWING);
                  break;
               case "backgroundLayer":
                  this.drawingLayer.setStyle("backgroundColor","0xdcdcdc");
                  this.sketchLayer.setStyle("backgroundColor","0xdcdcdc");
                  this.backgroundLayer.setStyle("backgroundColor","0x939393");
                  this._pc.setActiveBitmapData(SHPainterCanvas.BACKGROUND);
                  break;
               case "sketchLayer":
                  this.drawingLayer.setStyle("backgroundColor","0xdcdcdc");
                  this.backgroundLayer.setStyle("backgroundColor","0xdcdcdc");
                  this.sketchLayer.setStyle("backgroundColor","0x939393");
                  this._pc.setActiveBitmapData(SHPainterCanvas.SKETCH);
                  break;
            }
         }
         return;
      }

      private function createTutorial() : void {
         dispatchEvent(new Event(OPEN_EDITOR));
         return;
      }

      private var cursorID:int;

      private var cursorInCanvas:Boolean = false;

      private function canvasMouseOver(param1:MouseEvent) : void {
         this.cursorInCanvas=true;
         if((this.chkShowPencil.selected) && !this.cursorID)
         {
            this.cursorID=CursorManager.setCursor(this.PenCursor);
         }
         return;
      }

      private function canvasMouseOut(param1:MouseEvent) : void {
         this.cursorInCanvas=false;
         CursorManager.removeCursor(this.cursorID);
         this.cursorID=null;
         return;
      }

      private function updateCursorVisibility() : void {
         if((this.cursorInCanvas) && !this.chkShowPencil.selected && (this.cursorID))
         {
            CursorManager.removeCursor(this.cursorID);
         }
         else
         {
            if((this.cursorInCanvas) && (this.chkShowPencil.selected) && !this.cursorID)
            {
               this.cursorID=CursorManager.setCursor(this.PenCursor);
            }
         }
         return;
      }

      private var _isCtrlDown:Boolean = false;

      private function upKeyHandler(param1:KeyboardEvent) : void {
         if(param1.keyCode == Keyboard.CONTROL)
         {
            this._isCtrlDown=false;
         }
         return;
      }

      private function keyHandler(param1:KeyboardEvent) : void {
         if(param1.keyCode == Keyboard.CONTROL)
         {
            this._isCtrlDown=true;
            return;
         }
         if(!this._isCtrlDown)
         {
            switch(param1.keyCode)
            {
               case 80:
                  this.bPenTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 66:
                  this.bBrushTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 83:
                  this.bAirBrushTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 67:
                  this.bCircleTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 81:
                  this.bRectangleTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 87:
                  this.bPolygonTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 69:
                  this.bEraseTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 32:
                  this.bZoomPan.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 32:
                  this.bZoomPan.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case Keyboard.NUMPAD_ADD:
                  this.bZoomIn.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case Keyboard.NUMPAD_SUBTRACT:
                  this.bZoomOut.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 71:
                  this.bGridVisibility.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 76:
                  this.bLineTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 75:
                  this.bCurveTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 73:
                  this.bColorPicker.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 65:
                  this.bSmudgeTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 70:
                  this.bFillTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
               case 72:
                  this.chkShowPencil.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  this.updateCursorVisibility();
                  break;
               case Keyboard.SHIFT:
                  this.chkFullScreen.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
                  break;
            }
         }
         else
         {
            if(param1.keyCode == 90)
            {
               if(param1.altKey)
               {
                  this.bRedoTool.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
               }
               else
               {
                  this.bUndo.dispatchEvent(new MouseEvent(MouseEvent.CLICK,true,false));
               }
            }
         }
         return;
      }

      private function printPaint(param1:MouseEvent=null) : void {
         Printer.print(this.drawingCanvas);
         return;
      }

      private var helpDrawPopUp:HelpDrawPopUp;

      private function showHelpDrawPopUp(param1:MouseEvent=null) : void {
         this.helpDrawPopUp.verticalScrollPolicy="auto";
         PopUpManager.addPopUp(this.helpDrawPopUp,this.mainCanvas,true);
         PopUpManager.centerPopUp(this.helpDrawPopUp);
         this.helpDrawPopUp.addEventListener(Event.CLOSE,this.closeHelpDrawPopUp);
         return;
      }

      private function closeHelpDrawPopUp(param1:Event) : void {
         this.helpDrawPopUp.removeEventListener(Event.CLOSE,this.closeHelpDrawPopUp);
         PopUpManager.removePopUp(this.helpDrawPopUp);
         return;
      }

      private var extWarningPopUp:MissedExtensionWarning;

      private var _aClass:Array;

      private var _prevActiveToolSkin:String;

      private var _drawing:CheckButton;

      private var _cFullScreen:CheckButton;

      private var _cGrid:CheckButton;

      private var _backing:CheckButton;

      private var _sketching:CheckButton;

      private function showExtWarningPopUp() : void {
         this.extWarningPopUp.verticalScrollPolicy="auto";
         PopUpManager.addPopUp(this.extWarningPopUp,this,true);
         PopUpManager.centerPopUp(this.extWarningPopUp);
         this.extWarningPopUp.addEventListener(Event.CLOSE,this.closeExtWarningPopUp);
         return;
      }

      private function closeExtWarningPopUp(param1:Event) : void {
         this.extWarningPopUp.removeEventListener(Event.CLOSE,this.closeExtWarningPopUp);
         PopUpManager.removePopUp(this.extWarningPopUp);
         this.onSaveProject();
         return;
      }

      public function ___Drawing_Canvas1_creationComplete(param1:FlexEvent) : void {
         this.init();
         return;
      }

      public function __sliderOpacity_change(param1:SliderEvent) : void {
         this.changeOpacity();
         return;
      }

      public function __sliderThickness_change(param1:SliderEvent) : void {
         this.changeThickness();
         return;
      }

      public function __chkFullScreen_change(param1:Event) : void {
         this.setFullScreenMode();
         return;
      }

      public function __drawingLayer_mouseDown(param1:MouseEvent) : void {
         this.layerClicked(param1);
         return;
      }

      public function __chkDrawingVisibility_change(param1:Event) : void {
         this.setLayerVisibility(2);
         return;
      }

      public function __backgroundLayer_mouseDown(param1:MouseEvent) : void {
         this.layerClicked(param1);
         return;
      }

      public function __chkBackgroundVisibility_change(param1:Event) : void {
         this.setLayerVisibility(1);
         return;
      }

      public function __sketchLayer_mouseDown(param1:MouseEvent) : void {
         this.layerClicked(param1);
         return;
      }

      public function __chkSketchVisibility_change(param1:Event) : void {
         this.setLayerVisibility(0);
         return;
      }

      public function __cpForegroundColor_change(param1:ColorPickerEvent) : void {
         this.changeForegroundColor(param1);
         return;
      }

      public function __parentCanv_mouseOver(param1:MouseEvent) : void {
         this.canvasMouseOver(param1);
         return;
      }

      public function __parentCanv_mouseOut(param1:MouseEvent) : void {
         this.canvasMouseOut(param1);
         return;
      }

      public function __bPenTool_click(param1:MouseEvent) : void {
         this.toolClicked(param1);
         return;
      }

      public function __bBrushTool_click(param1:MouseEvent) : void {
         this.toolClicked(param1);
         return;
      }

      public function __bPolygonTool_click(param1:MouseEvent) : void {
         this.toolClicked(param1);
         return;
      }

      public function __bAirBrushTool_click(param1:MouseEvent) : void {
         this.toolClicked(param1);
         return;
      }

      public function __bRectangleTool_click(param1:MouseEvent) : void {
         this.toolClicked(param1);
         return;
      }

      public function __bCircleTool_click(param1:MouseEvent) : void {
         this.toolClicked(param1);
         return;
      }

      public function __bLineTool_click(param1:MouseEvent) : void {
         this.toolClicked(param1);
         return;
      }

      public function __bCurveTool_click(param1:MouseEvent) : void {
         this.toolClicked(param1);
         return;
      }

      public function __bSmudgeTool_click(param1:MouseEvent) : void {
         this.toolClicked(param1);
         return;
      }

      public function __bEraseTool_click(param1:MouseEvent) : void {
         this.toolClicked(param1);
         return;
      }

      public function __bColorPicker_click(param1:MouseEvent) : void {
         this.pickColor();
         return;
      }

      public function __bGridVisibility_click(param1:MouseEvent) : void {
         this.changeGridVisibility();
         return;
      }

      public function __bZoomPan_click(param1:MouseEvent) : void {
         this.zoomDragging();
         return;
      }

      public function __bFillTool_click(param1:MouseEvent) : void {
         this.toolClicked(param1);
         return;
      }

      public function __bUndo_click(param1:MouseEvent) : void {
         this.undo();
         return;
      }

      public function __bRedoTool_click(param1:MouseEvent) : void {
         this.redo();
         return;
      }

      public function __bZoomIn_click(param1:MouseEvent) : void {
         this.zoom("in");
         return;
      }

      public function __bZoomOut_click(param1:MouseEvent) : void {
         this.zoom("out");
         return;
      }

      mx_internal var _Drawing_StylesInit_done:Boolean = false;

      mx_internal function _Drawing_StylesInit() : void {
         var style:CSSStyleDeclaration = null;
         var effects:Array = null;
         if(mx_internal::_Drawing_StylesInit_done)
         {
            return;
         }
         mx_internal::_Drawing_StylesInit_done=true;
         style=styleManager.getStyleDeclaration(".bTool");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".bTool",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.upSkin=_embed_css____assets_drawing_tools_icons_tool_botton_png_78593253_325737899;
               this.downSkin=_embed_css____assets_drawing_tools_icons_tool_botton_over_png__1597897019_958623879;
               this.overSkin=_embed_css____assets_drawing_tools_icons_tool_botton_over_png__1597897019_958623879;
               this.disabledSkin=_embed_css____assets_drawing_tools_icons_tool_botton_over_png__1597897019_958623879;
               return;
            };
         }
         style=styleManager.getStyleDeclaration(".chkLayerVisibility");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".chkLayerVisibility",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.selectedOverIcon=_embed_css____assets_drawing_palette_lay_eye_png_118764447_435901823;
               this.selectedUpIcon=_embed_css____assets_drawing_palette_lay_eye_png_118764447_435901823;
               this.upIcon=_embed_css____assets_drawing_palette_lay_eye_uncheck_png__1130360863_1158331233;
               this.selectedDownIcon=_embed_css____assets_drawing_palette_lay_eye_png_118764447_435901823;
               this.overIcon=_embed_css____assets_drawing_palette_lay_eye_uncheck_png__1130360863_1158331233;
               this.downIcon=_embed_css____assets_drawing_palette_lay_eye_uncheck_png__1130360863_1158331233;
               return;
            };
         }
         style=styleManager.getStyleDeclaration(".chkInfo");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".chkInfo",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.selectedOverIcon=_embed_css____assets_drawing_palette_info_del_check_jpg__260650370_1872988606;
               this.selectedUpIcon=_embed_css____assets_drawing_palette_info_del_check_jpg__260650370_1872988606;
               this.upIcon=_embed_css____assets_drawing_palette_info_del_1_jpg__805051737_1598899109;
               this.selectedDownIcon=_embed_css____assets_drawing_palette_info_del_check_jpg__260650370_1872988606;
               this.overIcon=_embed_css____assets_drawing_palette_info_del_1_jpg__805051737_1598899109;
               this.downIcon=_embed_css____assets_drawing_palette_info_del_1_jpg__805051737_1598899109;
               return;
            };
         }
         style=styleManager.getStyleDeclaration(".chkSwatchPen");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".chkSwatchPen",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.selectedOverIcon=_embed_css____assets_drawing_palette_swatches_pen_jpg_2042738765_1442896911;
               this.selectedUpIcon=_embed_css____assets_drawing_palette_swatches_pen_jpg_2042738765_1442896911;
               this.upIcon=_embed_css____assets_drawing_palette_swatches_pen_uncheck_jpg__690602353_788560077;
               this.selectedDownIcon=_embed_css____assets_drawing_palette_swatches_pen_jpg_2042738765_1442896911;
               this.overIcon=_embed_css____assets_drawing_palette_swatches_pen_uncheck_jpg__690602353_788560077;
               this.downIcon=_embed_css____assets_drawing_palette_swatches_pen_uncheck_jpg__690602353_788560077;
               return;
            };
         }
         style=styleManager.getStyleDeclaration(".chkSwatchFill");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".chkSwatchFill",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.selectedOverIcon=_embed_css____assets_drawing_palette_swatches_fil_jpg_1870306109_737407871;
               this.selectedUpIcon=_embed_css____assets_drawing_palette_swatches_fil_jpg_1870306109_737407871;
               this.upIcon=_embed_css____assets_drawing_palette_swatches_fil_uncheck_jpg__21679745_1180792637;
               this.selectedDownIcon=_embed_css____assets_drawing_palette_swatches_fil_jpg_1870306109_737407871;
               this.overIcon=_embed_css____assets_drawing_palette_swatches_fil_uncheck_jpg__21679745_1180792637;
               this.downIcon=_embed_css____assets_drawing_palette_swatches_fil_uncheck_jpg__21679745_1180792637;
               return;
            };
         }
         style=styleManager.getStyleDeclaration(".opacitySlider");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".opacitySlider",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.dataTipOffset=0;
               this.trackSkin=_embed_css____assets_drawing_slider_opacity_line_PNG_1314965359_284293905;
               this.dataTipPlacement=right;
               this.thumbSkin=_embed_css____assets_drawing_slider_opacity_button_PNG__1695852627_727782515;
               return;
            };
         }
         style=styleManager.getStyleDeclaration(".strokeSlider");
         if(!style)
         {
            style=new CSSStyleDeclaration(null,styleManager);
            StyleManager.setStyleDeclaration(".strokeSlider",style,false);
         }
         if(style.factory == null)
         {
            style.factory=new function():void
            {
               this.dataTipOffset=0;
               this.trackSkin=_embed_css____assets_drawing_slider_stroke_line_PNG_756335206_405040870;
               this.dataTipPlacement=right;
               this.thumbSkin=_embed_css____assets_drawing_slider_stroke_button_PNG__1668517660_542213352;
               return;
            };
         }
         return;
      }

      private var _embed_mxml____assets_drawing_tools_icons_pencil_png_1979317486:Class;

      private var _embed_css____assets_drawing_palette_swatches_pen_jpg_2042738765_1442896911:Class;

      private var _embed_mxml____assets_drawing_tools_icons_zoom_in_png_1224049970:Class;

      private var _embed_mxml____assets_drawing_tools_icons_broken_line_png_860816940:Class;

      private var _embed_mxml____assets_drawing_tools_icons_undo_png_1049814784:Class;

      private var _embed_css____assets_drawing_palette_info_del_check_jpg__260650370_1872988606:Class;

      private var _embed_css____assets_drawing_slider_opacity_button_PNG__1695852627_727782515:Class;

      private var _embed_mxml____assets_drawing_tools_icons_bucket_png_1848910796:Class;

      private var _embed_css____assets_drawing_palette_swatches_fil_jpg_1870306109_737407871:Class;

      private var _embed_css____assets_drawing_palette_swatches_fil_uncheck_jpg__21679745_1180792637:Class;

      private var _embed_css____assets_drawing_tools_icons_tool_botton_over_png__1597897019_958623879:Class;

      private var _embed_mxml____assets_drawing_tools_icons_blue_line_png_1674178574:Class;

      private var _embed_mxml____assets_drawing_tools_icons_brush_png_2032237938:Class;

      private var _embed_mxml____assets_drawing_tools_icons_redo_png_110488844:Class;

      private var _embed_mxml____assets_drawing_tools_icons_erase_png_1631341146:Class;

      private var _embed_css____assets_drawing_palette_info_del_1_jpg__805051737_1598899109:Class;

      private var _embed_css____assets_drawing_slider_stroke_line_PNG_756335206_405040870:Class;

      private var _embed_css____assets_drawing_slider_opacity_line_PNG_1314965359_284293905:Class;

      private var _embed_mxml____assets_drawing_tools_icons_squer_png_509948910:Class;

      private var _embed_mxml____assets_drawing_tools_icons_loyodea_png_1137205468:Class;

      private var _embed_mxml____assets_drawing_tools_icons_line_png_2124343008:Class;

      private var _embed_mxml____assets_drawing_tools_icons_knife_png_1218627936:Class;

      private var _embed_css____assets_drawing_palette_lay_eye_png_118764447_435901823:Class;

      private var _embed_mxml____assets_drawing_tools_icons_finger_png_1623712714:Class;

      private var _embed_css____assets_drawing_palette_swatches_pen_uncheck_jpg__690602353_788560077:Class;

      private var _embed_mxml____assets_drawing_tools_icons_move_png_378793254:Class;

      private var _embed_css____assets_drawing_tools_icons_tool_botton_png_78593253_325737899:Class;

      private var _embed_mxml____assets_drawing_set_close_option_close_option_01_png_148655952:Class;

      private var _embed_css____assets_drawing_slider_stroke_button_PNG__1668517660_542213352:Class;

      private var _embed_mxml____assets_drawing_tools_icons_spray_can_png_1941504016:Class;

      private var _embed_css____assets_drawing_palette_lay_eye_uncheck_png__1130360863_1158331233:Class;

      private var _embed_mxml____assets_drawing_tools_icons_zoom_out_png_1752007302:Class;

      private var _embed_mxml____assets_drawing_tools_icons_igul_png_2036994706:Class;

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

      public function get bAirBrushTool() : RButton {
         return this._1878551734bAirBrushTool;
      }

      public function set bAirBrushTool(param1:RButton) : void {
         var _loc2_:Object = this._1878551734bAirBrushTool;
         if(_loc2_ !== param1)
         {
            this._1878551734bAirBrushTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bAirBrushTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bBrushTool() : RButton {
         return this._144722512bBrushTool;
      }

      public function set bBrushTool(param1:RButton) : void {
         var _loc2_:Object = this._144722512bBrushTool;
         if(_loc2_ !== param1)
         {
            this._144722512bBrushTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bBrushTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bCircleTool() : RButton {
         return this._875035786bCircleTool;
      }

      public function set bCircleTool(param1:RButton) : void {
         var _loc2_:Object = this._875035786bCircleTool;
         if(_loc2_ !== param1)
         {
            this._875035786bCircleTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bCircleTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bColorPicker() : Button {
         return this._1976187889bColorPicker;
      }

      public function set bColorPicker(param1:Button) : void {
         var _loc2_:Object = this._1976187889bColorPicker;
         if(_loc2_ !== param1)
         {
            this._1976187889bColorPicker=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bColorPicker",_loc2_,param1));
            }
         }
         return;
      }

      public function get bCurveTool() : RButton {
         return this._696859877bCurveTool;
      }

      public function set bCurveTool(param1:RButton) : void {
         var _loc2_:Object = this._696859877bCurveTool;
         if(_loc2_ !== param1)
         {
            this._696859877bCurveTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bCurveTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bEraseTool() : RButton {
         return this._1845093604bEraseTool;
      }

      public function set bEraseTool(param1:RButton) : void {
         var _loc2_:Object = this._1845093604bEraseTool;
         if(_loc2_ !== param1)
         {
            this._1845093604bEraseTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bEraseTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bFillTool() : RButton {
         return this._1701299139bFillTool;
      }

      public function set bFillTool(param1:RButton) : void {
         var _loc2_:Object = this._1701299139bFillTool;
         if(_loc2_ !== param1)
         {
            this._1701299139bFillTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bFillTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bGridVisibility() : Button {
         return this._2090165242bGridVisibility;
      }

      public function set bGridVisibility(param1:Button) : void {
         var _loc2_:Object = this._2090165242bGridVisibility;
         if(_loc2_ !== param1)
         {
            this._2090165242bGridVisibility=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bGridVisibility",_loc2_,param1));
            }
         }
         return;
      }

      public function get bHelp() : Button {
         return this._92750531bHelp;
      }

      public function set bHelp(param1:Button) : void {
         var _loc2_:Object = this._92750531bHelp;
         if(_loc2_ !== param1)
         {
            this._92750531bHelp=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bHelp",_loc2_,param1));
            }
         }
         return;
      }

      public function get bLineTool() : RButton {
         return this._216421934bLineTool;
      }

      public function set bLineTool(param1:RButton) : void {
         var _loc2_:Object = this._216421934bLineTool;
         if(_loc2_ !== param1)
         {
            this._216421934bLineTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bLineTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bPenTool() : RButton {
         return this._21684337bPenTool;
      }

      public function set bPenTool(param1:RButton) : void {
         var _loc2_:Object = this._21684337bPenTool;
         if(_loc2_ !== param1)
         {
            this._21684337bPenTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bPenTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bPolygonTool() : RButton {
         return this._400555056bPolygonTool;
      }

      public function set bPolygonTool(param1:RButton) : void {
         var _loc2_:Object = this._400555056bPolygonTool;
         if(_loc2_ !== param1)
         {
            this._400555056bPolygonTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bPolygonTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bRectangleTool() : RButton {
         return this._50436709bRectangleTool;
      }

      public function set bRectangleTool(param1:RButton) : void {
         var _loc2_:Object = this._50436709bRectangleTool;
         if(_loc2_ !== param1)
         {
            this._50436709bRectangleTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bRectangleTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bRedoTool() : Button {
         return this._1743721672bRedoTool;
      }

      public function set bRedoTool(param1:Button) : void {
         var _loc2_:Object = this._1743721672bRedoTool;
         if(_loc2_ !== param1)
         {
            this._1743721672bRedoTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bRedoTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bSmudgeTool() : RButton {
         return this._768758081bSmudgeTool;
      }

      public function set bSmudgeTool(param1:RButton) : void {
         var _loc2_:Object = this._768758081bSmudgeTool;
         if(_loc2_ !== param1)
         {
            this._768758081bSmudgeTool=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bSmudgeTool",_loc2_,param1));
            }
         }
         return;
      }

      public function get bUndo() : Button {
         return this._93146214bUndo;
      }

      public function set bUndo(param1:Button) : void {
         var _loc2_:Object = this._93146214bUndo;
         if(_loc2_ !== param1)
         {
            this._93146214bUndo=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bUndo",_loc2_,param1));
            }
         }
         return;
      }

      public function get bZoomIn() : Button {
         return this._536404134bZoomIn;
      }

      public function set bZoomIn(param1:Button) : void {
         var _loc2_:Object = this._536404134bZoomIn;
         if(_loc2_ !== param1)
         {
            this._536404134bZoomIn=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bZoomIn",_loc2_,param1));
            }
         }
         return;
      }

      public function get bZoomOut() : Button {
         return this._551347129bZoomOut;
      }

      public function set bZoomOut(param1:Button) : void {
         var _loc2_:Object = this._551347129bZoomOut;
         if(_loc2_ !== param1)
         {
            this._551347129bZoomOut=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bZoomOut",_loc2_,param1));
            }
         }
         return;
      }

      public function get bZoomPan() : Button {
         return this._551347464bZoomPan;
      }

      public function set bZoomPan(param1:Button) : void {
         var _loc2_:Object = this._551347464bZoomPan;
         if(_loc2_ !== param1)
         {
            this._551347464bZoomPan=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"bZoomPan",_loc2_,param1));
            }
         }
         return;
      }

      public function get backgroundLayer() : Canvas {
         return this._1295031491backgroundLayer;
      }

      public function set backgroundLayer(param1:Canvas) : void {
         var _loc2_:Object = this._1295031491backgroundLayer;
         if(_loc2_ !== param1)
         {
            this._1295031491backgroundLayer=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"backgroundLayer",_loc2_,param1));
            }
         }
         return;
      }

      public function get brushChooser() : BrushChooser {
         return this._1135319201brushChooser;
      }

      public function set brushChooser(param1:BrushChooser) : void {
         var _loc2_:Object = this._1135319201brushChooser;
         if(_loc2_ !== param1)
         {
            this._1135319201brushChooser=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"brushChooser",_loc2_,param1));
            }
         }
         return;
      }

      public function get chkBackgroundVisibility() : CheckBox {
         return this._348674214chkBackgroundVisibility;
      }

      public function set chkBackgroundVisibility(param1:CheckBox) : void {
         var _loc2_:Object = this._348674214chkBackgroundVisibility;
         if(_loc2_ !== param1)
         {
            this._348674214chkBackgroundVisibility=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chkBackgroundVisibility",_loc2_,param1));
            }
         }
         return;
      }

      public function get chkDrawingVisibility() : CheckBox {
         return this._683001290chkDrawingVisibility;
      }

      public function set chkDrawingVisibility(param1:CheckBox) : void {
         var _loc2_:Object = this._683001290chkDrawingVisibility;
         if(_loc2_ !== param1)
         {
            this._683001290chkDrawingVisibility=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chkDrawingVisibility",_loc2_,param1));
            }
         }
         return;
      }

      public function get chkFullScreen() : CheckBox {
         return this._550261471chkFullScreen;
      }

      public function set chkFullScreen(param1:CheckBox) : void {
         var _loc2_:Object = this._550261471chkFullScreen;
         if(_loc2_ !== param1)
         {
            this._550261471chkFullScreen=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chkFullScreen",_loc2_,param1));
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

      public function get chkSketchVisibility() : CheckBox {
         return this._1563106468chkSketchVisibility;
      }

      public function set chkSketchVisibility(param1:CheckBox) : void {
         var _loc2_:Object = this._1563106468chkSketchVisibility;
         if(_loc2_ !== param1)
         {
            this._1563106468chkSketchVisibility=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"chkSketchVisibility",_loc2_,param1));
            }
         }
         return;
      }

      public function get colorSwatcher() : ColorSwatcher {
         return this._1184727660colorSwatcher;
      }

      public function set colorSwatcher(param1:ColorSwatcher) : void {
         var _loc2_:Object = this._1184727660colorSwatcher;
         if(_loc2_ !== param1)
         {
            this._1184727660colorSwatcher=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"colorSwatcher",_loc2_,param1));
            }
         }
         return;
      }

      public function get cpForegroundColor() : ColorPicker {
         return this._2145307571cpForegroundColor;
      }

      public function set cpForegroundColor(param1:ColorPicker) : void {
         var _loc2_:Object = this._2145307571cpForegroundColor;
         if(_loc2_ !== param1)
         {
            this._2145307571cpForegroundColor=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"cpForegroundColor",_loc2_,param1));
            }
         }
         return;
      }

      public function get drawingCanvas() : RCanvas {
         return this._999717098drawingCanvas;
      }

      public function set drawingCanvas(param1:RCanvas) : void {
         var _loc2_:Object = this._999717098drawingCanvas;
         if(_loc2_ !== param1)
         {
            this._999717098drawingCanvas=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"drawingCanvas",_loc2_,param1));
            }
         }
         return;
      }

      public function get drawingLayer() : Canvas {
         return this._716663853drawingLayer;
      }

      public function set drawingLayer(param1:Canvas) : void {
         var _loc2_:Object = this._716663853drawingLayer;
         if(_loc2_ !== param1)
         {
            this._716663853drawingLayer=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"drawingLayer",_loc2_,param1));
            }
         }
         return;
      }

      public function get info_pallete() : VBox {
         return this._503646772info_pallete;
      }

      public function set info_pallete(param1:VBox) : void {
         var _loc2_:Object = this._503646772info_pallete;
         if(_loc2_ !== param1)
         {
            this._503646772info_pallete=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"info_pallete",_loc2_,param1));
            }
         }
         return;
      }

      public function get layers_pallete() : VBox {
         return this._892426552layers_pallete;
      }

      public function set layers_pallete(param1:VBox) : void {
         var _loc2_:Object = this._892426552layers_pallete;
         if(_loc2_ !== param1)
         {
            this._892426552layers_pallete=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"layers_pallete",_loc2_,param1));
            }
         }
         return;
      }

      public function get mainCanvas() : Canvas {
         return this._10782607mainCanvas;
      }

      public function set mainCanvas(param1:Canvas) : void {
         var _loc2_:Object = this._10782607mainCanvas;
         if(_loc2_ !== param1)
         {
            this._10782607mainCanvas=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"mainCanvas",_loc2_,param1));
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

      public function get right_controls() : Canvas {
         return this._1832561287right_controls;
      }

      public function set right_controls(param1:Canvas) : void {
         var _loc2_:Object = this._1832561287right_controls;
         if(_loc2_ !== param1)
         {
            this._1832561287right_controls=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"right_controls",_loc2_,param1));
            }
         }
         return;
      }

      public function get sketchLayer() : Canvas {
         return this._1185643259sketchLayer;
      }

      public function set sketchLayer(param1:Canvas) : void {
         var _loc2_:Object = this._1185643259sketchLayer;
         if(_loc2_ !== param1)
         {
            this._1185643259sketchLayer=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sketchLayer",_loc2_,param1));
            }
         }
         return;
      }

      public function get sliderOpacity() : HSlider {
         return this._1153333270sliderOpacity;
      }

      public function set sliderOpacity(param1:HSlider) : void {
         var _loc2_:Object = this._1153333270sliderOpacity;
         if(_loc2_ !== param1)
         {
            this._1153333270sliderOpacity=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sliderOpacity",_loc2_,param1));
            }
         }
         return;
      }

      public function get sliderThickness() : HSlider {
         return this._1050086291sliderThickness;
      }

      public function set sliderThickness(param1:HSlider) : void {
         var _loc2_:Object = this._1050086291sliderThickness;
         if(_loc2_ !== param1)
         {
            this._1050086291sliderThickness=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sliderThickness",_loc2_,param1));
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
   }

}