package components
{
   import mx.containers.Canvas;
   import mx.controls.Image;
   import mx.core.UIComponentDescriptor;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import com.reinatech.shpainter.events.BrushChangedEvent;
   import mx.events.PropertyChangeEvent;
   import mx.containers.VBox;
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

   use namespace mx_internal;

   public class BrushChooser extends Canvas
   {
      public function BrushChooser() {
         this._documentDescriptor_=new UIComponentDescriptor(
            {
               "type":Canvas,
               "propertiesFactory":new function():Object
               {
                  return {"childDescriptors":[new UIComponentDescriptor(
                     {
                        "type":VBox,
                        "propertiesFactory":new function():Object
                        {
                           return {"childDescriptors":[new UIComponentDescriptor(
                              {
                                 "type":Image,
                                 "id":"imgCurrBrush",
                                 "propertiesFactory":new function():Object
                                 {
                                    return {
                                    "visible":false,
                                    "width":17,
                                    "height":17,
                                    "source":_embed_mxml_brushes_brush1_swf_1317320169
                                 }
                                 ;
                              }
                        }
                        ),new UIComponentDescriptor(
                        {
                              "type":Canvas,
                              "id":"brushShooser",
                              "propertiesFactory":new function():Object
                              {
                                 return {"childDescriptors":[new UIComponentDescriptor(
                                    {
                                       "type":Canvas,
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "width":124,
                                          "height":216
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas4_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush1_swf_1317320169;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":14,
                                          "y":11,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas5_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush2_swf_1315783913;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":34,
                                          "y":11,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas6_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush3_swf_1317869549;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":55,
                                          "y":11,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas7_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush4_swf_1319453933;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":77,
                                          "y":11,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas8_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush5_swf_1317385705;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":99,
                                          "y":11,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas9_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush6_swf_1325237481;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":14,
                                          "y":33,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas10_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush7_swf_1325226981;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":34,
                                          "y":33,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas11_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush8_swf_1317354725;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":55,
                                          "y":33,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas12_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush9_swf_1319452137;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":77,
                                          "y":33,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas13_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush10_swf_1020857883;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":99,
                                          "y":33,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas14_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush11_swf_1019034907;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":14,
                                          "y":54,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas15_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush12_swf_1015114775;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":34,
                                          "y":54,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas16_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush13_swf_1016937751;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":55,
                                          "y":54,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas17_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush14_swf_1018760723;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":77,
                                          "y":54,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas18_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush15_swf_1021180179;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":99,
                                          "y":54,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas19_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush16_swf_1060251671;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":14,
                                          "y":76,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas20_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush17_swf_1058175255;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":34,
                                          "y":76,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas21_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush18_swf_1060769387;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":55,
                                          "y":76,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas22_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush19_swf_1071267179;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":77,
                                          "y":76,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas23_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush20_swf_1068630359;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":99,
                                          "y":76,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas24_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush21_swf_1070722651;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":14,
                                          "y":97,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas25_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush22_swf_1060978011;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":34,
                                          "y":97,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas26_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush23_swf_1058606167;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":55,
                                          "y":97,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas27_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush24_swf_1060994391;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":77,
                                          "y":97,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas28_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush25_swf_1019293267;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":99,
                                          "y":97,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas29_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush26_swf_1021180243;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":14,
                                          "y":118,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas30_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush27_swf_1018693719;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":34,
                                          "y":118,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas31_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush28_swf_1016871255;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":55,
                                          "y":118,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas32_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush29_swf_1018195563;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":77,
                                          "y":118,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas33_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush30_swf_857498007;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":99,
                                          "y":118,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas34_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush31_swf_859316631;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":14,
                                          "y":140,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas35_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush32_swf_870056347;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":34,
                                          "y":140,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas36_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush33_swf_867302811;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":55,
                                          "y":140,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas37_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush34_swf_865938839;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":77,
                                          "y":140,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas38_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush35_swf_867794327;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":99,
                                          "y":140,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas39_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush36_swf_870124947;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":14,
                                          "y":160,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas40_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush37_swf_868301203;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":34,
                                          "y":160,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas41_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush38_swf_859695511;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":55,
                                          "y":160,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas42_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush39_swf_857356695;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":77,
                                          "y":160,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas43_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush40_swf_781856339;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":99,
                                          "y":160,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas44_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush41_swf_780271959;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":14,
                                          "y":181,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas45_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush42_swf_784466007;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":34,
                                          "y":181,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas46_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush43_swf_786047323;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":55,
                                          "y":181,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas47_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush44_swf_792329819;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":77,
                                          "y":181,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas48_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush45_swf_790433111;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":99,
                                          "y":181,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas49_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush46_swf_791755863;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":14,
                                          "y":201,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas50_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush47_swf_803040595;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":34,
                                          "y":201,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas51_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush48_swf_800669267;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":55,
                                          "y":201,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas52_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush49_swf_798820695;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":77,
                                          "y":201,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              ),new UIComponentDescriptor(
                              {
                                    "type":Canvas,
                                    "events":{"mouseUp":"___BrushChooser_Canvas53_mouseUp"},
                                    "stylesFactory":new function():void
                                    {
                                       this.backgroundImage=_embed_mxml_brushes_brush50_swf_724696339;
                                       return;
                                       },
                                       "propertiesFactory":new function():Object
                                       {
                                          return {
                                          "x":99,
                                          "y":201,
                                          "width":16,
                                          "height":16,
                                          "buttonMode":true
                                       }
                                       ;
                                    }
                              }
                              )]};
                        }
                     }
                     )]};
               }
            }
            )]};
         }
         }
         );
         this._embed_mxml_brushes_brush29_swf_1018195563=BrushChooser__embed_mxml_brushes_brush29_swf_1018195563;
         this._embed_mxml_brushes_brush25_swf_1019293267=BrushChooser__embed_mxml_brushes_brush25_swf_1019293267;
         this._embed_mxml_brushes_brush10_swf_1020857883=BrushChooser__embed_mxml_brushes_brush10_swf_1020857883;
         this._embed_mxml_brushes_brush6_swf_1325237481=BrushChooser__embed_mxml_brushes_brush6_swf_1325237481;
         this._embed_mxml_brushes_brush8_swf_1317354725=BrushChooser__embed_mxml_brushes_brush8_swf_1317354725;
         this._embed_mxml_brushes_brush13_swf_1016937751=BrushChooser__embed_mxml_brushes_brush13_swf_1016937751;
         this._embed_mxml_brushes_brush1_swf_1317320169=BrushChooser__embed_mxml_brushes_brush1_swf_1317320169;
         this._embed_mxml_brushes_brush34_swf_865938839=BrushChooser__embed_mxml_brushes_brush34_swf_865938839;
         this._embed_mxml_brushes_brush43_swf_786047323=BrushChooser__embed_mxml_brushes_brush43_swf_786047323;
         this._embed_mxml_brushes_brush17_swf_1058175255=BrushChooser__embed_mxml_brushes_brush17_swf_1058175255;
         this._embed_mxml_brushes_brush4_swf_1319453933=BrushChooser__embed_mxml_brushes_brush4_swf_1319453933;
         this._embed_mxml_brushes_brush26_swf_1021180243=BrushChooser__embed_mxml_brushes_brush26_swf_1021180243;
         this._embed_mxml_brushes_brush16_swf_1060251671=BrushChooser__embed_mxml_brushes_brush16_swf_1060251671;
         this._embed_mxml_brushes_brush14_swf_1018760723=BrushChooser__embed_mxml_brushes_brush14_swf_1018760723;
         this._embed_mxml_brushes_brush45_swf_790433111=BrushChooser__embed_mxml_brushes_brush45_swf_790433111;
         this._embed_mxml_brushes_brush41_swf_780271959=BrushChooser__embed_mxml_brushes_brush41_swf_780271959;
         this._embed_mxml_brushes_brush42_swf_784466007=BrushChooser__embed_mxml_brushes_brush42_swf_784466007;
         this._embed_mxml_brushes_brush21_swf_1070722651=BrushChooser__embed_mxml_brushes_brush21_swf_1070722651;
         this._embed_mxml_brushes_brush35_swf_867794327=BrushChooser__embed_mxml_brushes_brush35_swf_867794327;
         this._embed_mxml_brushes_brush18_swf_1060769387=BrushChooser__embed_mxml_brushes_brush18_swf_1060769387;
         this._embed_mxml_brushes_brush27_swf_1018693719=BrushChooser__embed_mxml_brushes_brush27_swf_1018693719;
         this._embed_mxml_brushes_brush49_swf_798820695=BrushChooser__embed_mxml_brushes_brush49_swf_798820695;
         this._embed_mxml_brushes_brush40_swf_781856339=BrushChooser__embed_mxml_brushes_brush40_swf_781856339;
         this._embed_mxml_brushes_brush30_swf_857498007=BrushChooser__embed_mxml_brushes_brush30_swf_857498007;
         this._embed_mxml_brushes_brush22_swf_1060978011=BrushChooser__embed_mxml_brushes_brush22_swf_1060978011;
         this._embed_mxml_brushes_brush44_swf_792329819=BrushChooser__embed_mxml_brushes_brush44_swf_792329819;
         this._embed_mxml_brushes_brush39_swf_857356695=BrushChooser__embed_mxml_brushes_brush39_swf_857356695;
         this._embed_mxml_brushes_brush31_swf_859316631=BrushChooser__embed_mxml_brushes_brush31_swf_859316631;
         this._embed_mxml_brushes_brush36_swf_870124947=BrushChooser__embed_mxml_brushes_brush36_swf_870124947;
         this._embed_mxml_brushes_brush24_swf_1060994391=BrushChooser__embed_mxml_brushes_brush24_swf_1060994391;
         this._embed_mxml_brushes_brush23_swf_1058606167=BrushChooser__embed_mxml_brushes_brush23_swf_1058606167;
         this._embed_mxml_brushes_brush47_swf_803040595=BrushChooser__embed_mxml_brushes_brush47_swf_803040595;
         this._embed_mxml_brushes_brush32_swf_870056347=BrushChooser__embed_mxml_brushes_brush32_swf_870056347;
         this._embed_mxml_brushes_brush12_swf_1015114775=BrushChooser__embed_mxml_brushes_brush12_swf_1015114775;
         this._embed_mxml_brushes_brush33_swf_867302811=BrushChooser__embed_mxml_brushes_brush33_swf_867302811;
         this._embed_mxml_brushes_brush11_swf_1019034907=BrushChooser__embed_mxml_brushes_brush11_swf_1019034907;
         this._embed_mxml_brushes_brush46_swf_791755863=BrushChooser__embed_mxml_brushes_brush46_swf_791755863;
         this._embed_mxml_brushes_brush9_swf_1319452137=BrushChooser__embed_mxml_brushes_brush9_swf_1319452137;
         this._embed_mxml_brushes_brush2_swf_1315783913=BrushChooser__embed_mxml_brushes_brush2_swf_1315783913;
         this._embed_mxml_brushes_brush3_swf_1317869549=BrushChooser__embed_mxml_brushes_brush3_swf_1317869549;
         this._embed_mxml_brushes_brush5_swf_1317385705=BrushChooser__embed_mxml_brushes_brush5_swf_1317385705;
         this._embed_mxml_brushes_brush37_swf_868301203=BrushChooser__embed_mxml_brushes_brush37_swf_868301203;
         this._embed_mxml_brushes_brush19_swf_1071267179=BrushChooser__embed_mxml_brushes_brush19_swf_1071267179;
         this._embed_mxml_brushes_brush50_swf_724696339=BrushChooser__embed_mxml_brushes_brush50_swf_724696339;
         this._embed_mxml_brushes_brush28_swf_1016871255=BrushChooser__embed_mxml_brushes_brush28_swf_1016871255;
         this._embed_mxml_brushes_brush48_swf_800669267=BrushChooser__embed_mxml_brushes_brush48_swf_800669267;
         this._embed_mxml_brushes_brush38_swf_859695511=BrushChooser__embed_mxml_brushes_brush38_swf_859695511;
         this._embed_mxml_brushes_brush7_swf_1325226981=BrushChooser__embed_mxml_brushes_brush7_swf_1325226981;
         this._embed_mxml_brushes_brush20_swf_1068630359=BrushChooser__embed_mxml_brushes_brush20_swf_1068630359;
         this._embed_mxml_brushes_brush15_swf_1021180179=BrushChooser__embed_mxml_brushes_brush15_swf_1021180179;
         super();
         mx_internal::_document=this;
         return;
      }

      private var _1844491087brushShooser:Canvas;

      private var _1937933221imgCurrBrush:Image;

      private var _documentDescriptor_:UIComponentDescriptor;

      private var __moduleFactoryInitialized:Boolean = false;

      override public function set moduleFactory(param1:IFlexModuleFactory) : void {
         super.moduleFactory=param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized=true;
         return;
      }

      override public function initialize() : void {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
         return;
      }

      private function init() : void {
         return;
      }

      private function selectBrush(param1:MouseEvent, param2:int) : void {
         var _loc3_:Canvas = param1.currentTarget as Canvas;
         this.imgCurrBrush.source=_loc3_.getStyle("backgroundImage");
         dispatchEvent(new BrushChangedEvent(BrushChangedEvent.CHANGE,true,false,param2));
         return;
      }

      private function openBrushChooser() : void {
         this.brushShooser.visible=!this.brushShooser.visible;
         return;
      }

      private function mouseup(param1:MouseEvent) : void {
         this.brushShooser.removeEventListener(MouseEvent.MOUSE_UP,this.mouseup);
         stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseup);
         return;
      }

      public function ___BrushChooser_Canvas4_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,0);
         return;
      }

      public function ___BrushChooser_Canvas5_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,1);
         return;
      }

      public function ___BrushChooser_Canvas6_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,2);
         return;
      }

      public function ___BrushChooser_Canvas7_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,3);
         return;
      }

      public function ___BrushChooser_Canvas8_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,4);
         return;
      }

      public function ___BrushChooser_Canvas9_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,5);
         return;
      }

      public function ___BrushChooser_Canvas10_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,6);
         return;
      }

      public function ___BrushChooser_Canvas11_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,7);
         return;
      }

      public function ___BrushChooser_Canvas12_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,8);
         return;
      }

      public function ___BrushChooser_Canvas13_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,9);
         return;
      }

      public function ___BrushChooser_Canvas14_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,10);
         return;
      }

      public function ___BrushChooser_Canvas15_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,11);
         return;
      }

      public function ___BrushChooser_Canvas16_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,12);
         return;
      }

      public function ___BrushChooser_Canvas17_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,13);
         return;
      }

      public function ___BrushChooser_Canvas18_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,14);
         return;
      }

      public function ___BrushChooser_Canvas19_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,15);
         return;
      }

      public function ___BrushChooser_Canvas20_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,16);
         return;
      }

      public function ___BrushChooser_Canvas21_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,17);
         return;
      }

      public function ___BrushChooser_Canvas22_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,18);
         return;
      }

      public function ___BrushChooser_Canvas23_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,19);
         return;
      }

      public function ___BrushChooser_Canvas24_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,20);
         return;
      }

      public function ___BrushChooser_Canvas25_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,21);
         return;
      }

      public function ___BrushChooser_Canvas26_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,22);
         return;
      }

      public function ___BrushChooser_Canvas27_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,23);
         return;
      }

      public function ___BrushChooser_Canvas28_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,24);
         return;
      }

      public function ___BrushChooser_Canvas29_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,25);
         return;
      }

      public function ___BrushChooser_Canvas30_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,26);
         return;
      }

      public function ___BrushChooser_Canvas31_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,27);
         return;
      }

      public function ___BrushChooser_Canvas32_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,28);
         return;
      }

      public function ___BrushChooser_Canvas33_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,29);
         return;
      }

      public function ___BrushChooser_Canvas34_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,30);
         return;
      }

      public function ___BrushChooser_Canvas35_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,31);
         return;
      }

      public function ___BrushChooser_Canvas36_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,32);
         return;
      }

      public function ___BrushChooser_Canvas37_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,33);
         return;
      }

      public function ___BrushChooser_Canvas38_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,34);
         return;
      }

      public function ___BrushChooser_Canvas39_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,35);
         return;
      }

      public function ___BrushChooser_Canvas40_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,36);
         return;
      }

      public function ___BrushChooser_Canvas41_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,37);
         return;
      }

      public function ___BrushChooser_Canvas42_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,38);
         return;
      }

      public function ___BrushChooser_Canvas43_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,39);
         return;
      }

      public function ___BrushChooser_Canvas44_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,40);
         return;
      }

      public function ___BrushChooser_Canvas45_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,41);
         return;
      }

      public function ___BrushChooser_Canvas46_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,42);
         return;
      }

      public function ___BrushChooser_Canvas47_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,43);
         return;
      }

      public function ___BrushChooser_Canvas48_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,44);
         return;
      }

      public function ___BrushChooser_Canvas49_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,45);
         return;
      }

      public function ___BrushChooser_Canvas50_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,46);
         return;
      }

      public function ___BrushChooser_Canvas51_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,47);
         return;
      }

      public function ___BrushChooser_Canvas52_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,48);
         return;
      }

      public function ___BrushChooser_Canvas53_mouseUp(param1:MouseEvent) : void {
         this.selectBrush(param1,49);
         return;
      }

      private var _embed_mxml_brushes_brush29_swf_1018195563:Class;

      private var _embed_mxml_brushes_brush25_swf_1019293267:Class;

      private var _embed_mxml_brushes_brush10_swf_1020857883:Class;

      private var _embed_mxml_brushes_brush6_swf_1325237481:Class;

      private var _embed_mxml_brushes_brush8_swf_1317354725:Class;

      private var _embed_mxml_brushes_brush13_swf_1016937751:Class;

      private var _embed_mxml_brushes_brush1_swf_1317320169:Class;

      private var _embed_mxml_brushes_brush34_swf_865938839:Class;

      private var _embed_mxml_brushes_brush43_swf_786047323:Class;

      private var _embed_mxml_brushes_brush17_swf_1058175255:Class;

      private var _embed_mxml_brushes_brush4_swf_1319453933:Class;

      private var _embed_mxml_brushes_brush26_swf_1021180243:Class;

      private var _embed_mxml_brushes_brush16_swf_1060251671:Class;

      private var _embed_mxml_brushes_brush14_swf_1018760723:Class;

      private var _embed_mxml_brushes_brush45_swf_790433111:Class;

      private var _embed_mxml_brushes_brush41_swf_780271959:Class;

      private var _embed_mxml_brushes_brush42_swf_784466007:Class;

      private var _embed_mxml_brushes_brush21_swf_1070722651:Class;

      private var _embed_mxml_brushes_brush35_swf_867794327:Class;

      private var _embed_mxml_brushes_brush18_swf_1060769387:Class;

      private var _embed_mxml_brushes_brush27_swf_1018693719:Class;

      private var _embed_mxml_brushes_brush49_swf_798820695:Class;

      private var _embed_mxml_brushes_brush40_swf_781856339:Class;

      private var _embed_mxml_brushes_brush30_swf_857498007:Class;

      private var _embed_mxml_brushes_brush22_swf_1060978011:Class;

      private var _embed_mxml_brushes_brush44_swf_792329819:Class;

      private var _embed_mxml_brushes_brush39_swf_857356695:Class;

      private var _embed_mxml_brushes_brush31_swf_859316631:Class;

      private var _embed_mxml_brushes_brush36_swf_870124947:Class;

      private var _embed_mxml_brushes_brush24_swf_1060994391:Class;

      private var _embed_mxml_brushes_brush23_swf_1058606167:Class;

      private var _embed_mxml_brushes_brush47_swf_803040595:Class;

      private var _embed_mxml_brushes_brush32_swf_870056347:Class;

      private var _embed_mxml_brushes_brush12_swf_1015114775:Class;

      private var _embed_mxml_brushes_brush33_swf_867302811:Class;

      private var _embed_mxml_brushes_brush11_swf_1019034907:Class;

      private var _embed_mxml_brushes_brush46_swf_791755863:Class;

      private var _embed_mxml_brushes_brush9_swf_1319452137:Class;

      private var _embed_mxml_brushes_brush2_swf_1315783913:Class;

      private var _embed_mxml_brushes_brush3_swf_1317869549:Class;

      private var _embed_mxml_brushes_brush5_swf_1317385705:Class;

      private var _embed_mxml_brushes_brush37_swf_868301203:Class;

      private var _embed_mxml_brushes_brush19_swf_1071267179:Class;

      private var _embed_mxml_brushes_brush50_swf_724696339:Class;

      private var _embed_mxml_brushes_brush28_swf_1016871255:Class;

      private var _embed_mxml_brushes_brush48_swf_800669267:Class;

      private var _embed_mxml_brushes_brush38_swf_859695511:Class;

      private var _embed_mxml_brushes_brush7_swf_1325226981:Class;

      private var _embed_mxml_brushes_brush20_swf_1068630359:Class;

      private var _embed_mxml_brushes_brush15_swf_1021180179:Class;

      public function get brushShooser() : Canvas {
         return this._1844491087brushShooser;
      }

      public function set brushShooser(param1:Canvas) : void {
         var _loc2_:Object = this._1844491087brushShooser;
         if(_loc2_ !== param1)
         {
            this._1844491087brushShooser=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"brushShooser",_loc2_,param1));
            }
         }
         return;
      }

      public function get imgCurrBrush() : Image {
         return this._1937933221imgCurrBrush;
      }

      public function set imgCurrBrush(param1:Image) : void {
         var _loc2_:Object = this._1937933221imgCurrBrush;
         if(_loc2_ !== param1)
         {
            this._1937933221imgCurrBrush=param1;
            if(this.hasEventListener("propertyChange"))
            {
               this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"imgCurrBrush",_loc2_,param1));
            }
         }
         return;
      }
   }

}