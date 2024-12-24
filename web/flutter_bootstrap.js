{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
    onEntrypointLoaded: async function onEntrypointLoaded(engineInitializer) {
        
        let engine = await engineInitializer.initializeEngine({
            multiViewEnabled: true, // Enables embedded mode.
        });
        let app = await engine.runApp();
        app.addView({
            hostElement: document.querySelector('#flutter-element'),
            // viewConstraints: {
            //   minWidth: 0,
            //   minHeight: 0,
            //   // maxHeight: Infinity,
            // }
        });
        // let lastScrollTop = 0;
        // let scroollBottom=false;
    
        // window.onscroll = function() {
        //   const scrollPosition = window.scrollY + window.innerHeight;
        //   const documentHeight = document.body.scrollHeight;
        //   const currentScrollTop = window.scrollY;
    
        //   if (scrollPosition >= documentHeight) {
        //     if (currentScrollTop > lastScrollTop) {
        //         if(!scroollBottom){
        //           console.log('dsfdsfdfsdfsdfs');
        //             window.postMessage({ action: 'scrollToBottom', value: true });
        //             scroollBottom=true
        //             const style = document.createElement('style');
        //             style.innerHTML = `
        //               body::-webkit-scrollbar-thumb:hover {
        //                 background: white;
        //               }
        //             `;
        //             document.head.appendChild(style)
        //         }
        //     }
        //   }else{            
        //     if(scroollBottom){
        //       window.postMessage({ action: 'scrollToBottom', value: false });
        //       scroollBottom=false;
        //       document.body.style.overflow =  'auto';              
        //   }
        //   }
    
        //   lastScrollTop = currentScrollTop <= 0 ? 0 : currentScrollTop;
        // };
    }
});