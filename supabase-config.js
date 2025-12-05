// Supabase Configuration
const SUPABASE_URL = 'https://ezsurtlznvwsncszfckj.supabase.co'
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV6c3VydGx6bnZ3c25jc3pmY2tqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ1NTc2OTQsImV4cCI6MjA4MDEzMzY5NH0.uuqPr1J_K9ChNWYmydsPyQUEDKAxJaiSzl1qU2TAjcc'

// Initialize Supabase client
const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY)
