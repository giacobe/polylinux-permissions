# PolyLinux Users, Groups, and Permissions

Extract every file in this archive directly into `/root` of the sudo-enabled
Buildroot image. Run:

```sh
/root/install.sh
```

The installer:

- creates `/home` when it is absent;
- creates 24 realistic company accounts in four departments;
- creates `level1` through `level10`;
- grants the level accounts passwordless sudo through the `sysadmin` group;
- derives the exercise code from the current date as uppercase hexadecimal `YYYYMMDD`;
- derives each level hash from email, exercise code, system password, and level password;
- builds level 1 synchronously and levels 2 through 10 in parallel;
- enters `level1` when installation completes.

Before production deployment, replace `SYSTEM_PASSWORD` and
`LEVEL_PASSWORD_PREFIX` in `resources.sh` with the production values used by
the PolyLab grader.
