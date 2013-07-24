package mx.graphics.shaderClasses
{
   import flash.display.Shader;


   public class ColorDodgeShader extends Shader
   {
      public function ColorDodgeShader() {
         super(new ShaderClass());
         return;
      }

      private static var ShaderClass:Class = ColorDodgeShader_ShaderClass;
   }

}