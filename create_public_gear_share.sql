-- SQL script to create public gear share functionality
-- This allows users to share their entire gear collection publicly

-- Create public_gear_shares table
CREATE TABLE IF NOT EXISTS public_gear_shares (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  share_token TEXT UNIQUE NOT NULL,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for faster lookups
CREATE INDEX IF NOT EXISTS idx_public_gear_shares_user_id ON public_gear_shares(user_id);
CREATE INDEX IF NOT EXISTS idx_public_gear_shares_token ON public_gear_shares(share_token);

-- Enable Row Level Security
ALTER TABLE public_gear_shares ENABLE ROW LEVEL SECURITY;

-- Policy: Users can create their own share link (only one per user)
CREATE POLICY "Users can create their own public share"
  ON public_gear_shares FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Policy: Users can view their own share link
CREATE POLICY "Users can view their own public share"
  ON public_gear_shares FOR SELECT
  USING (auth.uid() = user_id);

-- Policy: Users can update their own share link
CREATE POLICY "Users can update their own public share"
  ON public_gear_shares FOR UPDATE
  USING (auth.uid() = user_id);

-- Policy: Users can delete their own share link
CREATE POLICY "Users can delete their own public share"
  ON public_gear_shares FOR DELETE
  USING (auth.uid() = user_id);

-- Policy: Anyone can read public shares by token (for public viewing)
CREATE POLICY "Anyone can view active public shares by token"
  ON public_gear_shares FOR SELECT
  USING (is_active = true);

-- Add unique constraint to ensure one share per user
CREATE UNIQUE INDEX IF NOT EXISTS idx_public_gear_shares_one_per_user ON public_gear_shares(user_id) WHERE is_active = true;

-- Comments
COMMENT ON TABLE public_gear_shares IS 'Stores public share links for entire gear collections';
COMMENT ON COLUMN public_gear_shares.share_token IS 'Unique token for accessing the public gear view';
COMMENT ON COLUMN public_gear_shares.is_active IS 'Whether this share link is currently active';
