package PPP::Babble::Grammar::Role::TryTiny;
# ABSTRACT: Use Try::Tiny for try-catch syntax

use Moo::Role;

around grammar_regexp => sub {
	my $orig = shift;
	my $ret = $orig->(@_);
	qr{
		# from PPR@0.001004 t/trytiny.t
		(?(DEFINE)
			# Turn off built-in try/catch syntax...
			(?<PerlTryCatchFinallyBlock>   (?!)  )

			# Decanonize 'try' and 'catch' as reserved words ineligible for sub names...
			(?<PPR_X_non_reserved_identifier>
				(?! (?> for(?:each)?+ | while   | if    | unless | until | given | when   | default
					|   sub | format  | use     | no    | my     | our   | state  | defer | finally
					# Note: Removed 'try' and 'catch' which appear here in the original subrule
					|   (?&PPR_X_named_op)
					|   [msy] | q[wrxq]?+ | tr
					|   __ (?> END | DATA ) __
					)
					\b
					)
				(?>(?&PerlQualifiedIdentifier))
				(?! :: )
			)
		)

		$ret
	}x;
};

1;
