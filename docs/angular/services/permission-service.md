# Permission Service

!!! warning
    The permission service can only be use in the constructor of shared module, permission can be use in hasRight directive or RoleGuardService

## Create permission

First, you'll create a new permission for both your pages and actions. In order to do it add the permission in the following file : custom-permission.ts

```typescript
export enum CustomPermission {
    //add permission in this enumeration
    viewCustom = 'view.custom',
}
```

## Manage permission

### Create group

A group of permissions need to be linked with a real group available in administration interface (linked by name).

```typescript
this.permissionService.addGroup(
    // group name
    'CUSTOM',
    // list of permissions
    [
        CustomPermission.viewCustom,
        MyrteaPermission.viewHome
    ]
);
```

### Add permission in group

```typescript
this.permissionService.addPermissions(
    'ADMIN',
    [ CustomPermission.viewCustom ]
);
```

### Remove permissions in group

```typescript
this.permissionService.removePermissions(
    'ADMIN',
    [ MyrteaPermission.viewSettings ]
);
```

### Replace permission in group

You can replace all permisions in group with replacePermissions function:

```typescript
this.permissionService.replacePermissions(
    'USER',
    [
        MyrteaPermission.viewHome,
        CustomPermission.viewCustom
    ]
);
```

### Remove group

```typescript
this.permissionService.removeGroup('USER');
```
