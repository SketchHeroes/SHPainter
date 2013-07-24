package mx.graphics.shaderClasses
{
   import flash.display.Shader;


   public class ColorBurnShader extends Shader
   {
      public function ColorBurnShader() {
         super(new ShaderClass());
         return;
      }

      private static var ShaderClass:Class = ColorBurnShader_ShaderClass;
   }

}