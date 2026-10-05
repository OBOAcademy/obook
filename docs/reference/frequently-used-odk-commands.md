# Frequently used ODK commands

## Updates the Makefile to the latest ODK

```
odkrun update_repo
```

## Recreates and deploys the automated documentation

```
odkrun make update_docs
```

## Preparing a new release

```
odkrun make prepare_release
```

## Refreshing a single import

```
odkrun make refresh-%
```

Example:

```
odkrun make refresh-chebi
```

## Refresh all imports

```
odkrun make refresh-imports
```

## Refresh all imports excluding large ones

```
odkrun make refresh-imports-excluding-large
```

## Run all the QC checks

```
odkrun make test
```

## Print the version of the currently installed ODK

```
odkrun make odkversion
```

## Checks the OWL2 DL profile validity

(of a specific file)

```
odkrun make validate_profile_%
```

Example:

```
odkrun make validate_profile_hp-edit.owl
```
