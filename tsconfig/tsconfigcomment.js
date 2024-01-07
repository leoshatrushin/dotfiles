let config = {
  "compilerOptions": {
    "strict": true,
    "target": "ESNext", // js output targets latest ECMAscript
    "module": "ESNext", // js output uses latest ECMAscirpt module standard
    "moduleResolution": "node",
    "allowSyntheticDefaultImports": true, // CommonJS interop
    "esModuleInterop": true, // CommonJS interop
    "jsx": "preserve", // transpiled later
    "jsxImportSource": "solid-js", // source and types for transpiler for jsx
    "types": ["vite/client"], // import type definitions for vite
    "noEmit": true, // don't emit js files, ts is a dev dependency
    "isolatedModules": true // ensure each file can be transpiled independently without type information from other files
  }
}
