# Syntax added in core Perl

- <https://metacpan.org/pod/feature>
- <https://metacpan.org/pod/B::Keywords>
- "Secret" combinations of operators: <https://metacpan.org/dist/perlsecret>
- <https://metacpan.org/pod/Syntax::Construct>
- Fallbacks to backport features:
    * `try`/`catch`: <https://metacpan.org/pod/Feature::Compat::Try>
    * `defer`: <https://metacpan.org/pod/Feature::Compat::Defer>
    * `builtin`: <https://metacpan.org/pod/builtins::compat>
    * `say`: <https://metacpan.org/pod/Say::Compat>, <https://metacpan.org/pod/say>

# Syntax extensions on CPAN

The following are various ways of extending the syntax. They might be
implemented as simple subroutine calls (e.g., used inline like `Try::Tiny`,
used as declarative code generators like `Moo`). They might be implemented as
source filters. They might use attributes. They might hook into the parser and
change how the code is interpreted. They might be implemented as keywords.

- `try`/`catch`
    * XS keyword plugin: <https://metacpan.org/pod/Syntax::Keyword::Try>
    * subs: <https://metacpan.org/pod/Try::Tiny>
    * <https://metacpan.org/pod/TryCatch> (uses Devel::Declare)
    * XS keyword plugin: <https://metacpan.org/pod/Syntax::Feature::Try>
    * <https://metacpan.org/pod/Try> (uses Devel::CallParser + Try::Tiny)
- `async`/`await`
    * XS keyword plugin: <https://metacpan.org/pod/Future::AsyncAwait>
    * PPR-based source filter: <https://metacpan.org/pod/PerlX::AsyncAwait>
- signatures + parameters
    * XS keyword plugin: <https://metacpan.org/pod/Function::Parameters>
    * <https://metacpan.org/pod/Method::Signatures> (uses Devel::Declare)
    * <https://metacpan.org/pod/Method::Signatures::Simple> (uses Devel::Declare)
    * <https://metacpan.org/pod/Smart::Args>
        + <https://metacpan.org/pod/Smart::Args::TypeTiny>
    * PPR-based source filter: <https://metacpan.org/pod/Method::Signatures::PP>
    * <https://metacpan.org/pod/signatures> (uses B::Hooks::Parser)
- multiple dispatch
    * XS keyword plugin: <https://metacpan.org/pod/Syntax::Keyword::MultiSub>
    * attributes: <https://metacpan.org/pod/Sub::Multi::Tiny>
    * <https://metacpan.org/pod/Class::Multimethods>
        + <https://www.foo.be/docs/tpj/issues/vol5_1/tpj0501-0010.html>
    * <https://metacpan.org/pod/Sub::MultiMethod>
    * <https://metacpan.org/pod/Sub::SymMethod>
