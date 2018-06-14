    let prelude = ./dhall/prelude.dhall 

in  let types = ./dhall/types.dhall 

in  let v = prelude.v

in  let Haskell2010 =
          [ prelude.types.Languages.Haskell2010 {=} ] : Optional types.Language

in  let pkg =
            λ(name : Text)
          → λ(version-range : types.VersionRange)
          → { bounds = version-range, package = name }

in  let pkgVer =
            λ(packageName : Text)
          → λ(minor : Text)
          → λ(major : Text)
          → pkg
            packageName
            ( prelude.intersectVersionRanges
              (prelude.orLaterVersion (v minor))
              (prelude.earlierVersion (v major))
            )

in  let deps =
          { etlas-cabal =
              pkgVer "etlas-cabal" "1.3.0.0" "1.4"
          , base =
              pkgVer "base" "4.5" "5"
          , bytestring =
              pkgVer "bytestring" "0.10" "0.11"
          , containers =
              pkgVer "containers" "0.5" "0.6"
          , dhall =
              pkgVer "dhall" "1.14.0" "1.15"
          , dhall-to-etlas =
              pkg "dhall-to-etlas" prelude.anyVersion
          , optparse-applicative =
              pkgVer "optparse-applicative" "0.13.2" "0.15"
          , prettyprinter =
              pkgVer "prettyprinter" "1.2.0.1" "1.3"
          , text =
              pkgVer "text" "1.2" "1.3"
          , transformers =
              pkgVer "transformers" "0.2.0.0" "0.6"
          , formatting =
              pkgVer "formatting" "6.3.1" "6.4"
          , hashable =
              pkgVer "hashable" "1.2.6.1" "1.3"
          , insert-ordered-containers =
              pkgVer "insert-ordered-containers" "0.2.1.0" "0.3"
          , vector =
              pkgVer "vector" "0.11.0.0" "0.13"
          , contravariant =
              pkgVer "contravariant" "1.4" "1.5"
          , Diff =
              pkgVer "Diff" "0.3.4" "0.4"
          , filepath =
              pkgVer "filepath" "1.4" "1.5"
          , tasty =
              pkgVer "tasty" "0.11" "1.2"
          , tasty-golden =
              pkgVer "tasty-golden" "2.3" "2.4"
          , semigroups =
              pkgVer "semigroups" "0.18.0" "0.19"
          }

in  let warning-options =
          [ "-Wall"
          , "-fno-warn-safe"
          , "-fno-warn-unsafe"
          , "-fno-warn-implicit-prelude"
          , "-fno-warn-missing-import-lists"
          , "-fno-warn-missing-local-sigs"
          , "-fno-warn-monomorphism-restriction"
          , "-fno-warn-name-shadowing"
          ]

in    prelude.utils.GitHub-project
      { owner = "eta-lang", repo = "dhall-to-etlas" }
    ⫽ { synopsis =
          "Compile Dhall expressions to Etlas files"
      , description =
          ''
          dhall-to-etlas takes Dhall expressions and compiles them into Etlas
          files. All of the features of Dhall are supported, such as let
          bindings and imports, and all features of Etlas are supported
          (including conditional stanzas).
          ''
      , category =
          "Distribution"
      , maintainer =
          "atreyu.bbb@gmail.com"
      , author =
          "Ollie Charles <ollie@ocharles.org.uk>"
      , extra-source-files =
          [ "Changelog.md"
          , "README.md"
          , "dhall/defaults/BuildInfo.dhall"
          , "dhall/defaults/Library.dhall"
          , "dhall/defaults/CompilerOptions.dhall"
          , "dhall/defaults/SourceRepo.dhall"
          , "dhall/defaults/TestSuite.dhall"
          , "dhall/defaults/Executable.dhall"
          , "dhall/defaults/Package.dhall"
          , "dhall/defaults/Benchmark.dhall"
          , "dhall/unconditional.dhall"
          , "dhall/prelude.dhall"
          , "dhall/types/VersionRange.dhall"
          , "dhall/types/OS.dhall"
          , "dhall/types/Guarded.dhall"
          , "dhall/types/License.dhall"
          , "dhall/types/Library.dhall"
          , "dhall/types/Version.dhall"
          , "dhall/types/Language.dhall"
          , "dhall/types/Extension.dhall"
          , "dhall/types/CompilerOptions.dhall"
          , "dhall/types/SourceRepo.dhall"
          , "dhall/types/TestSuite.dhall"
          , "dhall/types/Executable.dhall"
          , "dhall/types/Dependency.dhall"
          , "dhall/types/Mixin.dhall"
          , "dhall/types/Compiler.dhall"
          , "dhall/types/Config.dhall"
          , "dhall/types/Package.dhall"
          , "dhall/types/builtin.dhall"
          , "dhall/types/BuildType.dhall"
          , "dhall/types/RepoKind.dhall"
          , "dhall/types/Version/v.dhall"
          , "dhall/types/Arch.dhall"
          , "dhall/types/Scope.dhall"
          , "dhall/types/CustomSetup.dhall"
          , "dhall/types/Benchmark.dhall"
          , "dhall/types/Flag.dhall"
          , "dhall/types/ForeignLibrary.dhall"
          , "dhall/types/ModuleRenaming.dhall"
          , "dhall/types/RepoType.dhall"
          , "dhall/types/TestType.dhall"
          , "dhall/types/VersionRange/IntersectVersionRanges.dhall"
          , "dhall/types/VersionRange/WithinVersion.dhall"
          , "dhall/types/VersionRange/InvertVersionRange.dhall"
          , "dhall/types/VersionRange/EarlierVersion.dhall"
          , "dhall/types/VersionRange/DifferenceVersionRanges.dhall"
          , "dhall/types/VersionRange/ThisVersion.dhall"
          , "dhall/types/VersionRange/OrLaterVersion.dhall"
          , "dhall/types/VersionRange/OrEarlierVersion.dhall"
          , "dhall/types/VersionRange/AnyVersion.dhall"
          , "dhall/types/VersionRange/NotThisVersion.dhall"
          , "dhall/types/VersionRange/LaterVersion.dhall"
          , "dhall/types/VersionRange/NoVersion.dhall"
          , "dhall/types/VersionRange/MajorBoundVersion.dhall"
          , "dhall/types/VersionRange/UnionVersionRanges.dhall"
          , "dhall/types/SetupBuildInfo.dhall"
          , "dhall/types/SPDX.dhall"
          , "dhall/types/SPDX/License.dhall"
          , "dhall/types/SPDX/LicenseVersionOrLater.dhall"
          , "dhall/types/SPDX/Ref.dhall"
          , "dhall/types/SPDX/RefWithFile.dhall"
          , "dhall/types/SPDX/And.dhall"
          , "dhall/types/SPDX/Or.dhall"
          , "dhall/types/SPDX/LicenseExceptionId.dhall"
          , "dhall/types/SPDX/LicenseId.dhall"
          , "dhall/utils/package.dhall"
          , "dhall/utils/GitHub-project.dhall"
          , "dhall/utils/majorVersions.dhall"
          , "dhall/utils/mapSourceRepos.dhall"
          , "golden-tests/dhall-to-cabal/*.dhall"
          , "golden-tests/dhall-to-cabal/*.cabal"
          , "golden-tests/cabal-to-dhall/*.dhall"
          , "golden-tests/cabal-to-dhall/*.cabal"
          ]
      , license =
          prelude.types.Licenses.MIT {=}
      , license-files =
          [ "LICENSE" ]
      , version =
          v "1.1.0.0"
      , cabal-version =
          v "1.12"
      , library =
          prelude.unconditional.library
          (   prelude.defaults.Library
            ⫽ { build-depends =
                  [ deps.etlas-cabal
                  , deps.base
                  , deps.bytestring
                  , deps.containers
                  , deps.contravariant
                  , deps.dhall
                  , deps.formatting
                  , deps.hashable
                  , deps.insert-ordered-containers
                  , deps.text
                  , deps.transformers
                  , deps.vector
                  , deps.semigroups
                  ]
              , compiler-options =
                  prelude.defaults.CompilerOptions ⫽ { GHC = warning-options }
              , exposed-modules =
                  [ "DhallToCabal", "DhallLocation", "CabalToDhall" ]
              , hs-source-dirs =
                  [ "lib" ]
              , other-extensions =
                  [ prelude.types.Extensions.GADTs True
                  , prelude.types.Extensions.GeneralizedNewtypeDeriving True
                  , prelude.types.Extensions.LambdaCase True
                  , prelude.types.Extensions.OverloadedStrings True
                  , prelude.types.Extensions.RecordWildCards True
                  ]
              , other-modules =
                  [ "DhallToCabal.ConfigTree"
                  , "DhallToCabal.Diff"
                  , "Dhall.Extra"
                  , "Paths_dhall_to_etlas"
                  ]
              , default-language =
                  Haskell2010
              }
          )
      , executables =
          [ prelude.unconditional.executable
            "dhall-to-etlas"
            (   prelude.defaults.Executable
              ⫽ { build-depends =
                    [ deps.etlas-cabal
                    , deps.base
                    , deps.dhall
                    , deps.dhall-to-etlas
                    , deps.insert-ordered-containers
                    , deps.optparse-applicative
                    , deps.prettyprinter
                    , deps.text
                    , deps.transformers
                    ]
                , compiler-options =
                    prelude.defaults.CompilerOptions ⫽ { GHC = warning-options }
                , hs-source-dirs =
                    [ "exe" ]
                , main-is =
                    "Main.hs"
                , other-extensions =
                    [ prelude.types.Extensions.NamedFieldPuns True ]
                , other-modules =
                    [ "Paths_dhall_to_cabal" ]
                , autogen-modules =
                    [ "Paths_dhall_to_cabal" ]
                , default-language =
                    Haskell2010
                }
            )
          , prelude.unconditional.executable
            "etlas-to-dhall"
            (   prelude.defaults.Executable
              ⫽ { build-depends =
                    [ deps.base
                    , deps.dhall
                    , deps.bytestring
                    , deps.dhall-to-etlas
                    , deps.optparse-applicative
                    , deps.prettyprinter
                    , deps.text
                    ]
                , compiler-options =
                    prelude.defaults.CompilerOptions ⫽ { GHC = warning-options }
                , hs-source-dirs =
                    [ "cabal-to-dhall" ]
                , main-is =
                    "Main.hs"
                , other-extensions =
                    [ prelude.types.Extensions.NamedFieldPuns True ]
                , other-modules =
                    [ "Paths_dhall_to_etlas" ]
                , autogen-modules =
                    [ "Paths_dhall_to_etlas" ]
                , default-language =
                    Haskell2010
                }
            )
          ]
      , test-suites =
          [ prelude.unconditional.test-suite
            "golden-tests"
            (   prelude.defaults.TestSuite
              ⫽ { build-depends =
                    [ deps.base
                    , deps.etlas-cabal
                    , deps.Diff
                    , deps.bytestring
                    , deps.dhall
                    , deps.dhall-to-etlas
                    , deps.filepath
                    , deps.prettyprinter
                    , deps.tasty
                    , deps.tasty-golden
                    , deps.text
                    ]
                , compiler-options =
                    prelude.defaults.CompilerOptions ⫽ { GHC = warning-options }
                , hs-source-dirs =
                    [ "golden-tests" ]
                , type =
                    prelude.types.TestTypes.exitcode-stdio
                    { main-is = "GoldenTests.hs" }
                , default-language =
                    Haskell2010
                }
            )
          ]
      }
