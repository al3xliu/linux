# Curl Usage

## Common Options

**-#**, --progress-bar Make curl display a simple progress bar instead of the more informational standard meter.

**-b**, --cookie <name=data> Supply cookie with request. If no =, then specifies the cookie file to use (see -c).

**-c**, --cookie-jar <file name> File to save response cookies to.

**-d**, --data <data> Send specified data in POST request. Details provided below.

**-f**, --fail Fail silently (don't output HTML error form if returned).

**-F**, --form <name=content> Submit form data.

**-H**, --header <header> Headers to supply with request.

**-i**, --include Include HTTP headers in the output.

**-I**, --head Fetch headers only.

**-k**, --insecure Allow insecure connections to succeed.

**-L**, --location Follow redirects.

**-o**, --output <file> Write output to . Can use --create-dirs in conjunction with this to create any directories specified in the -o path.

**-O**, --remote-name Write output to file named like the remote file (only writes to current directory).

**-s**, --silent Silent (quiet) mode. Use with -S to force it to show errors.

**-v**, --verbose Provide more information (useful for debugging).

**-w**, --write-out <format> Make curl display information on stdout after a completed transfer. See man page for more details on available variables. Convenient way to force curl to append a newline to output: -w "\n" (can add to ~/.curlrc).

**-X**, --request The request method to use.

## Examples

- GET
- POST

  + `curl -H "Content-Type: application/json" -d '{"key1":"value1", "key2":"value2"}' -X POST http://localhost:9200/accounts/person/1`

  + `curl -d "param1=value1&param2=value2" -H "Content-Type: application/x-www-form-urlencoded" -X POST http://localhost:3000/data`

  + `curl -d "@data.json" -X POST http://localhost:3000/data`
