# Releasing SISUVim

SISUVim uses Semantic Versioning. A release tag is the publication trigger, so
the tagged commit must already be merged to `main` and have passing checks.

## Release checklist

1. Confirm `./tests/smoke.sh` passes locally.
2. Confirm the Plugin checks workflow is green for the candidate commit.
3. Move completed notes from `Unreleased` into a dated version section in
   `CHANGELOG.md`.
4. Commit and push the changelog change.
5. Create and push an annotated version tag, for example:

   ```sh
   git tag -a v0.2.0 -m "SISUVim v0.2.0"
   git push origin v0.2.0
   ```

The Release workflow validates the tag, runs the smoke suite, and creates the
GitHub release with generated notes. If a release check fails, fix the issue in
`main`, create a new version tag, and leave the failed tag untouched for audit
clarity.
