ng-dynamic-template-example
===========================

This example demonstrates how to deal with dynamic templates. 

```
  div(ng-init="x=222")
    div(ng-init='someDynamicTemplate="<div>hello {{x}}</div>")
      dynamicTemplate(template='someDynamicTemplate')
```
