    let prelude = ../../dhall/prelude.dhall 

in  let types = ../../dhall/types.dhall 

in  let v = prelude.v

in  let pkg =
            λ(name : Text)
          → λ(version-range : types.VersionRange)
          → { bounds = version-range, package = name }

in  let pkgAnyVer = λ(packageName : Text) → pkg packageName prelude.anyVersion

in  let etaImpl =
            λ(cfg : types.Config)
          → λ(ver : types.VersionRange)
          → cfg.impl (prelude.types.Compilers.Eta {=}) ver

in  let updateRepo =
          prelude.utils.mapSourceRepos
          (   λ(srcRepo : types.SourceRepo)
            →   srcRepo
              ⫽ { tag =
                    [ "0.1.5.1" ] : Optional Text
                , kind =
                    prelude.types.RepoKind.RepoThis {=}
                }
          )

in  let project =
          prelude.utils.GitHub-project
          { owner = "jneira", repo = "wai-servlet" }

in  updateRepo
    (   project
      ⫽ { description =
            "Integration of eta wai applications with the servlet api"
        , license =
            prelude.types.Licenses.BSD3 {=}
        , license-files =
            [ "LICENSE" ]
        , author =
            "Javier Neira Sanchez"
        , maintainer =
            "Javier Neira Sanchez <atreyu.bbb@gmail.com>"
        , version =
            v "0.1.5.1"
        , cabal-version =
            v "1.12"
        , category =
            "Web"
        , extra-source-files =
            [ "README.md" ]
        , stability =
            "Experimental"
        , flags =
            [ { default =
                  False
              , description =
                  "print debug output. not suitable for production"
              , manual =
                  False
              , name =
                  "wai-servlet-debug"
              }
            ]
        , library =
            [   λ(config : types.Config)
              →   prelude.defaults.Library
                ⫽ { exposed-modules =
                      [ "Network.Wai.Servlet", "Network.Wai.Servlet.Examples" ]
                  , other-modules =
                      [ "Network.Wai.Servlet.Request"
                      , "Network.Wai.Servlet.Response"
                      , "Network.Wai.Servlet.File"
                      , "Network.Wai.Servlet.Settings"
                      , "Javax.Servlet"
                      ]
                  , hs-source-dirs =
                      [ "src" ]
                  , default-language =
                      [ prelude.types.Languages.Haskell2010 {=}
                      ] : Optional types.Language
                  , build-depends =
                        [ pkg
                          "base"
                          ( prelude.intersectVersionRanges
                            (prelude.orLaterVersion (v "4.8"))
                            (prelude.earlierVersion (v "4.9"))
                          )
                        , pkgAnyVer "wai"
                        , pkgAnyVer "network"
                        , pkg "http-types" (prelude.orLaterVersion (v "0.10"))
                        , pkgAnyVer "http-date"
                        , pkgAnyVer "blaze-builder"
                        , pkgAnyVer "bytestring"
                        , pkgAnyVer "case-insensitive"
                        , pkgAnyVer "hashable"
                        , pkgAnyVer "utf8-string"
                        ]
                      # (       if etaImpl
                                   config
                                   (prelude.orLaterVersion (v "0.0.9.7"))
                          
                          then  [ pkgAnyVer "eta-java-interop" ]
                          
                          else  [] : List types.Dependency
                        )
                  , maven-depends =
                      [ "javax.servlet:servlet-api:2.5" ]
                  , java-sources =
                            if etaImpl
                               config
                               (prelude.orLaterVersion (v "0.0.9"))
                      
                      then  [ "java/Utils.java" ]
                      
                      else  [ "java/eta-0.0.6/Utils.java" ]
                  , cpp-options =
                        (       if etaImpl
                                   config
                                   (prelude.orLaterVersion (v "0.0.9.7"))
                          
                          then  [ "-DINTEROP" ]
                          
                          else  [] : List Text
                        )
                      # (       if etaImpl
                                   config
                                   (prelude.orEarlierVersion (v "0.7.0.2"))
                          
                          then  [ "-DPURE_JAVA_WITH" ]
                          
                          else  [] : List Text
                        )
                      # (       if config.flag "wai-servlet-debug"
                          
                          then  [ "-DWAI_SERVLET_DEBUG" ]
                          
                          else  [] : List Text
                        )
                  }
            ] : Optional (../../dhall/types/Guarded.dhall  types.Library)
        }
    )
