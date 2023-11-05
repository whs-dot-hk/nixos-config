use genco::fmt;
use genco::prelude::*;
use honey::hive::*;
use std::fs::File;

fn main() -> anyhow::Result<()> {
    let nixos_configurations = NixosConfigurations::new("x17");

    let tokens = quote!($nixos_configurations);

    let file = File::create("comb/laptop/nixosConfigurations.nix")?;
    let mut w = fmt::IoWriter::new(file);

    let fmt = fmt::Config::from_lang::<Nix>();
    let config = nix::Config::default();

    tokens.format_file(&mut w.as_formatter(&fmt), &config)?;
    Ok(())
}
