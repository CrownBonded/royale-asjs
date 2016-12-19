////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package org.apache.flex.mdl
{
    import org.apache.flex.mdl.supportClasses.MaterialIconBase;

    COMPILE::JS
    {
        import org.apache.flex.core.WrappedHTMLElement;
    }

    /**
     *  The Chip class provides a MDL UI-like appearance for
     *  a Chip.
     *
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion FlexJS 0.0
     */
    public class ButtonChip extends Button
    {
        public function ButtonChip()
        {
            super();
        
            className = "";
        }

        COMPILE::JS
        private var chip:HTMLButtonElement;

        COMPILE::JS
        private var _chipTextSpan:HTMLSpanElement;

        COMPILE::JS
        public function get chipTextSpan():HTMLSpanElement
        {
            return _chipTextSpan;
        }

        private var _text:String = "";
        /**
         *  The text of the link
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion FlexJS 0.0
         */
		override public function get text():String
		{
            return _text;            
		}
        override public function set text(value:String):void
		{
            _text = value;

			COMPILE::JS
			{
                if(textNode == null)
                {
                    textNode = document.createTextNode('') as Text;
                    element.appendChild(textNode);
                }
                
                textNode.nodeValue = value;	
			}
		}

        COMPILE::JS
        protected var textNode:Text;

        
        /**
         * @flexjsignorecoercion org.apache.flex.core.WrappedHTMLElement
         * @flexjsignorecoercion HTMLSpanElement
         * @flexjsignorecoercion HTMLButtonElement
         * @flexjsignorecoercion Text
         */
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
            typeNames = "mdl-chip";

            _chipTextSpan = document.createElement("span") as HTMLSpanElement;
            _chipTextSpan.classList.add("mdl-chip__text");

            textNode = document.createTextNode('') as Text;
            _chipTextSpan.appendChild(textNode);

            chip = document.createElement("button") as HTMLButtonElement;
            chip.appendChild(_chipTextSpan);

            element = chip as WrappedHTMLElement;

            positioner = element;
            element.flexjs_wrapper = this;

            return element;
        }
    }
}
